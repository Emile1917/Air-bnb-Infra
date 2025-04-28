

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "mydb"
  master_username    = "exampleuser"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  number_of_nodes = 2
  manage_master_password = true
  
}


resource "aws_redshift_cluster_iam_roles" "example" {
  cluster_identifier = aws_redshift_cluster.redshift_cluster.cluster_identifier
  iam_role_arns      = [aws_iam_role.example.arn]
}