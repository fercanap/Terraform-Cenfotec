resource "aws_dynamodb_table" "demoDB" {
  name         = "users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "N"
  }
  attribute {
    name = "username"
    type = "S"
  }
  attribute {
    name = "password"
    type = "S"
  }
  global_secondary_index {
    name            = "username"
    hash_key        = "username"
    projection_type = "ALL"
  }
	global_secondary_index {
    name            = "password"
    hash_key        = "password"
    projection_type = "ALL"
  }
}
resource "aws_dynamodb_table_item" "data" {
  table_name = aws_dynamodb_table.demoDB.name
  hash_key   = aws_dynamodb_table.demoDB.hash_key

  item       = <<ITEM
	{
		"ID": {"N": "1"},
		"username": {"S": "carlos"},
		"password": {"S": "password"}
	}
	ITEM
}


