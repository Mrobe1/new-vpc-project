# VPC Variables
variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

variable "vpc-cidr" {
  default     = "192.168.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "public-subnet-1-cidr" {
  default     = "192.168.1.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "private-subnet-1-cidr" {
  default     = "192.168.2.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private-subnet-2-cidr" {
  default     = "192.168.3.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}