
# Assignment 04

##  Problem Statements
### Category
- AWS Resources
- Terraform modules
- Terraform State management and state locking

### Details
In this assignment, we will create an end-to-end infrastructure using Terraform modules.

### Must Do
- Create the following resources using terraform resource block :
    - Create 1 VPC 
        - eg : `ninja-vpc-01`
    - Create 4 Subnet
        - 2 public subnet
            - eg : `ninja-pub-sub-01/02`
        - 2 private subnet
            - eg : `ninja-priv-sub-01/02`
    - Create instances in it ( bastion and private instance)
    - Create 1 IGW
        - eg : `ninja-igw-01`
    - Create 1 NAT 
        - eg : `ninja-nat-01`
    - Create 2 Route Table
        - 1 for public subnet
            - eg : `ninja-route-pub-01/02`
        - 1 for private subnet
            - eg : `ninja-route-priv-01/02`

- call the root modules using wrapper code for reusability
- Achieve terrafom state managemnet using S3 and terrafom state locking using dynamodb.

NOTE: Please make maximum use of variables and output file 
### Good to Do
- Convert your code in two modules named Network and Security
- Use data source while calling modules.
### References
- https://www.terraform.io/docs
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## First initialize the code by running the below command.
```
$ terraform init
```
![Screenshot from 2024-02-02 22-11-14](https://github.com/Kiran-dehlikar/test/assets/104997588/e5352a72-20bc-4cac-9401-04ae7763966b)

### After running the below command it will create infra.
```
$ terraform apply --auto-approve
```
### As you see on the left side the key for ssh is generated. ```tokyo_key.pem```
![Screenshot from 2024-02-02 22-22-41](https://github.com/Kiran-dehlikar/test/assets/104997588/c5302629-4531-4923-8f4e-1999a13f532b)

## Verify the infra
### VPC
![Screenshot from 2024-02-02 22-16-53](https://github.com/Kiran-dehlikar/test/assets/104997588/2e569833-c3e4-4636-ae24-34ec319b7da7)

## SUBNET
![Screenshot from 2024-02-02 22-17-11](https://github.com/Kiran-dehlikar/test/assets/104997588/2e982559-3403-4cb8-a046-ec726ba58b7f)

## Route Table
- For public route
![Screenshot from 2024-02-02 22-17-52](https://github.com/Kiran-dehlikar/test/assets/104997588/7d2b8969-fb81-45ec-b112-513a768dc2f5)
- For private route
![Screenshot from 2024-02-02 22-18-18](https://github.com/Kiran-dehlikar/test/assets/104997588/c680344a-b6aa-4564-ba00-4c387921a4a3)

## IGW
![Screenshot from 2024-02-02 22-18-33](https://github.com/Kiran-dehlikar/test/assets/104997588/7160fd81-a9e1-4d6e-8bae-730d5677bb36)

## NAT
![Screenshot from 2024-02-02 22-18-54](https://github.com/Kiran-dehlikar/test/assets/104997588/08eb4a12-e668-4ef3-989a-d86de828ebb7)

## Security group
![Screenshot from 2024-02-02 22-19-52](https://github.com/Kiran-dehlikar/test/assets/104997588/62d94bb2-5a7e-499f-99c6-dbe4604d2144)

## Key pairs
![Screenshot from 2024-02-02 22-21-30](https://github.com/Kiran-dehlikar/test/assets/104997588/1e6f32f7-e1db-414a-afc0-7bca819d4746)

## Instance
![Screenshot from 2024-02-02 22-20-32](https://github.com/Kiran-dehlikar/test/assets/104997588/bf8725dd-008a-4b78-9f81-41a0772ce8e3)

## For Terraform State management and state lockingu
### We use S3 bucket for state management and dynamodb for state locking.
- This is my code for that 
```
resource "aws_s3_bucket" "s3_bucket_demo_new" {
  bucket = "terraform-bucket-kiran"
}

resource "aws_dynamodb_table" "dynamo_db_table" {
  name = "terraform-dynamo-kiran"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
```
- Here we need one more file ```backend.tf``` to connect dyanmodb with s3 and acquire state in the remote/central location.
```
terraform {
  backend "s3" {
    bucket = "terraform-bucket-kiran"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    dynamodb_table = "terraform-dynamo-kiran"
  }
}
```
## S3 Bucket
![Screenshot from 2024-02-02 22-16-15](https://github.com/Kiran-dehlikar/test/assets/104997588/ee11c437-069b-4999-8e18-91ed136cda70)
## Dynamodb
![Screenshot from 2024-02-02 22-14-29](https://github.com/Kiran-dehlikar/test/assets/104997588/a8a43c8c-5ac4-4df3-b010-e13dd39f1ecf)
- Locking Info
  ![Screenshot from 2024-02-02 22-15-10](https://github.com/Kiran-dehlikar/test/assets/104997588/765b1881-d4fe-45c3-929e-f60daab0c318)



## Authors

- [Kiran Dehlikar](https://github.com/Kiran-dehlikar)

