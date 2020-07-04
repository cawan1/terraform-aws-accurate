
output "rds_instance_endpoint" {
  description = "Endpoint Connection"
  value       = "${module.db.this_db_instance_endpoint}"
}

output "rds_instance_name" {
  description = "The database name"
  value       = "${module.db.this_db_instance_name}"
}

output "rds_instance_username" {
  description = "The master username for the database"
  value       = "${module.db.this_db_instance_username}"
}