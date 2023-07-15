/* Syntax info: resource <providerName_resourceType> <the-name-that-you-choose-for-resource> {...}
                data     <providerName_resourceType> <the-name-that-you-choose-for-resource  {...}
- providerName is fixed for each provider ofc
- you can find resoureTypes in official Terraform docs, which are very good
*/

resource "aws_vpc" "development-vpc" {          # here you declare that you want a vpc
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development",                    # name is a built-in tag type
        vpc_env: "dev"                          # this is a completely custom key:value pair
    }
}

variable "dev-subnet-1-cidr-block" {            # if you define a variable, but you don't assign it a value, you will be prompted to enter the value when running
                                                # terraform apply;
                                                # OR you will have to pass the value in command line (terraform apply -var "dev-subnet-1-cidr-block=10.0.10.0/24")
    description = "Cidr block for dev subnet 1"
    default = "10.0.10.0/24"                    # default value is used if you don't pass an argument or varaibles file
    type = string                               # syntax for type constraints; you can have lists or objects as types, but I'm too lazy to type in an example atm
}

resource "aws_subnet" "dev-subnet-1" {          # here you declare that you want a subnet
    vpc_id = aws_vpc.development-vpc.id         # a subnet is created inside of a vpc; this is how you access a vpc that is created in you .tf files
    cidr_block = var.dev-subnet-1-cidr-block
    availability_zone = "eu-west-3a"
    tags = {
        Name: "subnet-1-dev"
    }
}

data "aws_vpc" "existing-vpc" {                 # here you retrieve an existing resource (vpc); by existing, I mean that it's not created by this .tf repo
                                                # but it already exists on AWS; data keyowrd is used to retrieve existing resources
    default = true                              # syntax to retrieve default vpc
}

variable "dev-subnet-2-cidr-block" {            # this variable is assigned a value in terraform.tfvars file
    description = "Cidr block for dev subnet 2"
}

resource "aws_subnet" "dev-subnet-2" {          # here you declare that you want a subnet
    vpc_id = data.aws_vpc.existing-vpc.id       # this is how you access a resource that is retrieved as "data"
    cidr_block = var.dev-subnet-2-cidr-block
    availability_zone = "eu-west-3a"
    tags = {
        Name: "subnet-2-dev"
    }
}

output "dev-subnet-1-id" {                      # output block is used to print out information at the end of running "terraform apply"
    value = aws_subnet.dev-subnet-1.id          # it simply prints out the value of the attribute defined here
}                                               # this can be handy when you're creating new infrastructure (for example, you can print out public IPs of EC2 instances)

output "dev-subnet-2-id" {
    value = aws_subnet.dev-subnet-2.id
}

# run terraform apply from console to update infrastructure

/* Deleting resources:
1. By deleting them from .tf files and running terraform apply
2. terraform destroy -target aws_subnet.dev-subnet-2

Which option to use?
- Use terraform apply so that you always have a configuration file that corresponds to the actual state of the infrastructure.
*/