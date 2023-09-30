output "rds_id" {
    value = aws_db_instance.db_instance.id
}

output "rds_identifier" {
    value = aws_db_instance.db_instance.identifier
}

output "replica_id" {
    value = aws_db_instance.test-replica.id
}

output "replica_identifier" {
    value = aws_db_instance.test-replica.identifier
}

output "replica_arn" {
    value = aws_db_instance.test-replica.arn
}
