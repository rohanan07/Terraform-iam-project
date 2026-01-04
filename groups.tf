resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group" "engineers" {
  name = "Engineers"
  path = "/groups/"
}

resource "aws_iam_group" "managers" {
  name = "Managers"
  path = "/groups/"
}

resource "aws_iam_group_policy_attachment" "mfa-policy-attachment" {
  for_each = {
    group1 = aws_iam_group.education.name
    group2 = aws_iam_group.engineers.name
    group3 = aws_iam_group.managers.name
  }
  
  group = each.value
  policy_arn = aws_iam_policy.force_mfa.arn
}

resource "aws_iam_group_membership" "education-membership" {
  name = "education-memberships"
  group = aws_iam_group.education.name
  users = [ for user in aws_iam_user.users: user.name if user.tags.Department == "Education" ]
}

resource "aws_iam_group_membership" "engineers-membership" {
  name = "engineers-memberships"
  group = aws_iam_group.engineers.name
  users = [ 
    for user in aws_iam_user.users: user.name if user.tags.Department == "Engineering"
   ]
}

resource "aws_iam_group_membership" "managers-membership" {
  name = "managers-membership"
  group = aws_iam_group.managers.name
  users = [  for user in aws_iam_user.users : user.name if contains(keys(user.tags), "JobTitle") && can(regex("Manager|CEO", user.tags.JobTitle)) ]
}

resource "aws_iam_group_policy_attachment" "engineers-policies-attachment" {
  for_each = {
    ec2_policy = aws_iam_policy.engineers_ec2.arn
    lambda_policy = aws_iam_policy.engineers_lambda.arn
    rds_policy = aws_iam_policy.engineers_rds.arn
    s3_policy = aws_iam_policy.engineers_s3.arn
    monitoring_policy = aws_iam_policy.engineers_monitoring.arn
  }

 group = aws_iam_group.engineers.name
 policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "education-policies-attachment" {

 group = aws_iam_group.education.name
 policy_arn = aws_iam_policy.education_read_only.arn
}

resource "aws_iam_group_policy_attachment" "managers-policies-attachment" {
 group = aws_iam_group.managers.name
 policy_arn = aws_iam_policy.managers_view_only.arn
}