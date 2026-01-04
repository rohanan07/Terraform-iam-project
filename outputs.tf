output "account_id" {
  value = data.aws_caller_identity.name.account_id
}

output "user_names" {
  value = [for user in local.users: "${user.first_name}${user.last_name}"]
}
