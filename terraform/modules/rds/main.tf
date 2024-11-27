resource "aws_db_instance" "postgres" {
  identifier         = "ipfs-postgres"
  engine             = "postgres"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  name               = "ipfsdb"
  username           = "admin"
  password           = "password"
  publicly_accessible = false
}
