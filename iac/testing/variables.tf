variable "cidr_block" {
  description = "CIDR Block"
  type = string
  default = "10.0.0.0/24"
}

variable "availability_zone"{
  description = "Availability Zones for the Subnet"
  type = string
  default = "eu-north-1a"
}