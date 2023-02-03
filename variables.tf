variable "private_subnet_name" {
  type = string
  default = "default"
}

variable "virtual_network_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "prefix" {
  default = "test"
}

variable "vm_size" {
  type = string
}

variable "adminpassword" {
  type = string
}