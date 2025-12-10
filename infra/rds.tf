#aws requires subnet groups even if rds is only in one 
resource "aws_db_subnet_group" "app" {
  name       = "${local.name_prefix}-db-subnet"
  subnet_ids = [aws_subnet.private.id]  # single subnet for now 
  tags       = merge(local.common_tags, { Name = "${local.name_prefix}-db-subnet" })
}


resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS ${local.name_prefix}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = merge(local.common_tags, { Name = "${local.name_prefix}-rds-kms" })
}

resource "random_password" "db" {
  length           = 20
  special          = true
  override_special = "!#$%&()*+,-.:;<=>?[]^_{|}~"
}

resource "aws_db_instance" "app" {
  identifier                = "${local.name_prefix}-postgresql"
  engine                    = "postgres"
  engine_version            = "15"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  storage_type              = "gp3"
  storage_encrypted         = true
  kms_key_id                = aws_kms_key.rds.arn

  db_subnet_group_name      = aws_db_subnet_group.app.name
  vpc_security_group_ids    = [aws_security_group.db.id]

  username                  = "admin"
  password                  = random_password.db.result
  db_name                   = "mydb"
  port                      = 5432

  multi_az                  = false  
  backup_retention_period   = 7

  #backups cuz why not
  backup_window             = "03:00-04:00"
  maintenance_window        = "sun:04:00-sun:05:00"
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot     = true

  deletion_protection       = false
  skip_final_snapshot       = true   

  publicly_accessible       = false
  apply_immediately         = true   

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-rds" })
}

