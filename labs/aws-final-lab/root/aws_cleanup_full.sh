#!/bin/bash

# AWS Cleanup Script - Generated 2025-06-05_18-16-08
# This script will detect and delete resources from the final lab, waiting for deletion to complete

set -euo pipefail

echo "Starting full AWS cleanup..."

delete_nat_gateway() {
  local nat_id=$1
  echo "Deleting NAT Gateway: $nat_id"
  aws ec2 delete-nat-gateway --nat-gateway-id "$nat_id"
  echo "Waiting for NAT Gateway $nat_id deletion..."
  aws ec2 wait nat-gateway-deleted --nat-gateway-ids "$nat_id"
}

delete_igw() {
  local igw_id=$1
  local vpc_id=$2
  echo "Detaching and deleting Internet Gateway: $igw_id from VPC: $vpc_id"
  aws ec2 detach-internet-gateway --internet-gateway-id "$igw_id" --vpc-id "$vpc_id"
  aws ec2 delete-internet-gateway --internet-gateway-id "$igw_id"
}

delete_subnet() {
  local subnet_id=$1
  echo "Deleting Subnet: $subnet_id"
  aws ec2 delete-subnet --subnet-id "$subnet_id"
}

delete_route_table() {
  local rtb_id=$1
  echo "Deleting Route Table: $rtb_id"
  aws ec2 delete-route-table --route-table-id "$rtb_id"
}

delete_security_group() {
  local sg_id=$1
  echo "Deleting Security Group: $sg_id"
  aws ec2 delete-security-group --group-id "$sg_id"
}

delete_vpc() {
  local vpc_id=$1
  echo "Deleting VPC: $vpc_id"
  aws ec2 delete-vpc --vpc-id "$vpc_id"
}

# === Delete NAT Gateways ===
delete_nat_gateway nat-0fcecf118a34b65d2
delete_nat_gateway nat-0d3df9ab724fb607e
delete_nat_gateway nat-0a263ffeb412022a1

# === Delete Internet Gateways ===
delete_igw igw-002a1662701650ed7 vpc-0ffa7f493bb81944c
delete_igw igw-063babc7f903537c8 vpc-086e06be627cd1949
delete_igw igw-0dc171453ccaf809f vpc-0d3ba670c46631a74

# === Delete Subnets ===
for subnet in subnet-01073bed474546021 subnet-08a6468584845842c subnet-0a192c51943a6f2e4 \
              subnet-0262fc486de6ceef0 subnet-052b01e7f74174ef1 subnet-0badb4017b32e111c \
              subnet-0f761512f6c8bc972 subnet-0e7c07056441f1f6e subnet-00421d827283abcfc; do
  delete_subnet $subnet
done

# === Delete Route Tables ===
for rtb in rtb-00c9bcb5aa8290b83 rtb-023756cd320433aff rtb-0e2a752321cf8d511 rtb-0da45db57eb0cdcaa \
           rtb-08fe887eb8d735b87 rtb-0b88badf6a0a1f27c rtb-03b4d9d8820d10838 rtb-09f224f65b5617787 \
           rtb-0927eaebbd046f32f rtb-07fbad39bf234f495; do
  delete_route_table $rtb
done

# === Delete Security Groups ===
for sg in sg-0e7a40c316e03f99c sg-0548b6ca3ab4913b7 sg-0dd57552a33bd3cbc sg-08b5e19fd806dd041 \
          sg-02437300309a45da9 sg-0f728c85aa0b9b11a sg-0e534f626be1b6d8d sg-0c593ec778dca8a0c \
          sg-0f418ba0387ed51c6 sg-08efd0051aeed70df sg-05d908a6f4769b5bf sg-0a847621e17d2ffd3 \
          sg-036517a5784466965; do
  delete_security_group $sg
done

# === Delete VPCs ===
for vpc in vpc-0d3ba670c46631a74 vpc-0ffa7f493bb81944c vpc-086e06be627cd1949 vpc-0eb8fe3792a3f0511; do
  delete_vpc $vpc
done

echo "AWS Cleanup completed."
