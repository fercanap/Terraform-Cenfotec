
# route table
resource "aws_route_table" "rt_nat" {
  depends_on = [aws_vpc.vpc, aws_nat_gateway.ngw]

  vpc_id = aws_vpc.vpc.id
}

# route from 0.0.0.0/0 to igw
# gateway_id diff:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "routeNat" {
  depends_on = [aws_route_table.rt_nat]

  route_table_id         = aws_route_table.rt_nat.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

# associations
resource "aws_route_table_association" "private_subnet_association_a" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rt_nat.id
}


