data "aws_availability_zones" "zone" {
  state = "available"
}

output "availability_zones" {
  value = data.aws_availability_zones.zone.names
}
