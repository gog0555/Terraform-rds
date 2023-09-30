variable "env" {
  type    = string
  default = "env"
}

variable "name" {
  type    = string
  default = "name"
}

variable "cidr_block" {
  type    = string
  default = "cidr_block"
}

variable "subnet" {
  type = map(any)
  default = {
    public_subnet = {
      public-1 = {
        name = "public-1"
        cidr = "10.0.1.0/24"
        az   = "ap-northeast-1a"
      },
      public-2 = {
        name = "public-2"
        cidr = "10.0.2.0/24"
        az   = "ap-northeast-1c"
      },
      public-3 = {
        name = "public-3"
        cidr = "10.0.3.0/24"
        az   = "ap-northeast-1d"
      },
    }
    private_subnet = {
      private-1 = {
        name = "private-1"
        cidr = "10.0.4.0/24"
        az   = "ap-northeast-1a"
      },
      private-2 = {
        name = "private-2"
        cidr = "10.0.5.0/24"
        az   = "ap-northeast-1c"
      },
      private-3 = {
        name = "private-3"
        cidr = "10.0.6.0/24"
        az   = "ap-northeast-1d"
      },
    }
  }
}

variable "instance_ami" {
  type    = string
  default = "ami-03a1b4db103179555"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "db_storage" {
  type    = string
  default = "20"
}

variable "db_storage_type" {
  type    = string
  default = "gp3"
}

variable "db_name" {
  type    = string
  default = "mydb"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_version" {
  type    = string
  default = "5.7"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_username" {
  type    = string
  default = "username"
}

variable "db_password" {
  type    = string
  default = "password"
}
