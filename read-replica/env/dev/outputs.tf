output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet" {
  value = module.network.public_subnet
}

output "private_subnet" {
  value = module.network.private_subnet
}
