resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "orders-details-joined"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "customer_id"
  range_key      = "id"

  attribute {
    name = "customer_id"
    type = "N"
  }
  
  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "demo-aws-confluent"
  }
}