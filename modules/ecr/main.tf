resource "aws_ecr_repository" "this" {
  count = length(var.images)
  name                 = "${var.project}/${var.images[count.index]}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}