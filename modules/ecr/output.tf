output "repositories" {
  value = {
      for repository in aws_ecr_repository.this:
        repository.name => repository.repository_url
  }
}