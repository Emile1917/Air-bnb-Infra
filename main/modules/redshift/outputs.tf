output "redshift_cluster_id" {
  value = aws_redshift_cluster.redshift_cluster.id 
}

output "redshift_cluster_arn" {
    value = aws_redshift_cluster.redshift_cluster.arn
}