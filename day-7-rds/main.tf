resource "aws_db_snapshot" "snapshot" {
  db_instance_identifier   = "terraform-20250715085948491700000001" # existing DB identifier
  db_snapshot_identifier   = "my-db-snapshot"
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = ["subnet-033efb53898efe44e", "subnet-03d6e9e102e04853b"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  identifier              = "new-db-instance"
  snapshot_identifier     = aws_db_snapshot.snapshot.id
  instance_class          = "db.t3.micro"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.name
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = false
  apply_immediately       = true

  lifecycle {
    create_before_destroy = true
  }
}

