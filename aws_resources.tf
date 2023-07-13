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

resource "aws_subnet" "dev-subnet-1" {          # here you declare that you want a subnet
    vpc_id = aws_vpc.development-vpc.id         # a subnet is created inside of a vpc; this is how you access a vpc that is created in you .tf files
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-west-3a"
    tags = {
        Name: "subnet-1-dev"
    }
}

data "aws_vpc" "existing-vpc" {                 # here you retrieve an existing resource (vpc); by existing, I mean that it's not created by this .tf repo
                                                # but it already exists on AWS; data keyowrd is used to retrieve existing resources
    default = true
}

resource "aws_subnet" "dev-subnet-2" {          # here you declare that you want a subnet
    vpc_id = data.aws_vpc.existing-vpc.id       # this is how you access a resource that is retrieved as "data"
    cidr_block = "172.31.64.0/20"
    availability_zone = "eu-west-3a"
    tags = {
        Name: "subnet-2-dev"
    }
}
