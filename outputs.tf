
locals {
  dummy_output = slice(["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 0, length(var.availability_zones))
}

output "az_subnet_ids" {
  value = zipmap(
    var.availability_zones,
    coalescelist(aws_subnet.private.*.id, aws_subnet.dmz.*.id, local.dummy_output),
  )
  description = "Map of AZ names to subnet IDs"
}

output "az_route_table_ids" {
  value = zipmap(
    var.availability_zones,
    coalescelist(aws_route_table.private.*.id, aws_route_table.dmz.*.id, local.dummy_output),
  )
  description = " Map of AZ names to Route Table IDs"
}

output "az_ngw_ids" {
  value = zipmap(
    var.availability_zones,
    coalescelist(aws_nat_gateway.dmz.*.id, local.dummy_output),
  )
  description = "Map of AZ names to NAT Gateway IDs (only for public subnets)"
}

output "az_subnet_arns" {
  value = zipmap(
    var.availability_zones,
    coalescelist(aws_subnet.private.*.arn, aws_subnet.dmz.*.arn, local.dummy_output),
  )
  description = "Map of AZ names to subnet ARNs"
}
