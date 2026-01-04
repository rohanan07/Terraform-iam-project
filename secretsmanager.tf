resource "aws_secretsmanager_secret" "passwords" {
  name = "users-initial-passwords"
}

resource "aws_secretsmanager_secret_version" "user_passwords" {
  secret_id = aws_secretsmanager_secret.passwords.id

  secret_string = jsonencode({
    for user, profile in aws_iam_user_login_profile.users_login_profiles: user => profile.password
  })
}