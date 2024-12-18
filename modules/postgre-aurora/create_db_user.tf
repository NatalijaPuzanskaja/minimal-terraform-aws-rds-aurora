################################################################################
#
################################################################################

resource "aws_ssm_document" "rds_bootstrap_document" {
  name            = "db_user"
  document_type   = "Command"
  document_format = "YAML"
  content = templatefile("${path.module}/templates/create_db_user.yml", {
    dbhost = aws_rds_cluster.this[0].endpoint
    dbport = var.port
    dbname = var.database_name
    pguser = var.db_user
  })
}

resource "null_resource" "run_rds_user_bootstrap" {
  provisioner "local-exec" {
    command = join(" ", [
      "aws ssm send-command --document-name ${aws_ssm_document.rds_bootstrap_document.name}",
      "--targets Key=tag:Name,Values=ssm-bastion-host",
      "--timeout-seconds 600",
      "--max-concurrency '1'",
      "--max-errors '0'",
      "--region ${var.aws_region}",
      "--output text",
      "--parameters '${join(",", [
        "{\"dbuser\":[\"${jsondecode(data.aws_secretsmanager_secret_version.db_pass_val.secret_string).username}\"]",
        "\"dbpassword\":[\"${jsondecode(data.aws_secretsmanager_secret_version.db_pass_val.secret_string).password}\"]}"
      ])}'"
    ])
  }

  depends_on = [aws_ssm_document.rds_bootstrap_document]

  triggers = {
    always_run = timestamp()  # Re-runs every time apply is called
  }
}
