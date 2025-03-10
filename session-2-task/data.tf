############### Terraform Remote State ###############
/* This block of code fetches data from 'hometask/homework-4/terraform.tfstate,' 
such as the VPC ID and Subnet IDs.
*/
# data "terraform_remote_state" "network" {
#   backend = "s3"

#   config = {
#     bucket = "terraform-homework-shirin"
#     key    = "hometask/homework-4/terrafrom.tfstate"
#     region = "us-east-1"
#   }
# }

# output "public_subnet" {
#   value = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
# }


