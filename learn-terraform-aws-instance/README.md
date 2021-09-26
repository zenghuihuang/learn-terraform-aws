## Usage
1. Use the command
```bash
terraform init
```
   to prepare a working directory containing Terraform configuration files.



2. Use the command
```bash
terraform plan
```
   to create an execution plan, but terraform will not make any changes until the command:

```bash
terraform apply
```
3. To terminate all the ec2 instances created, use the command:

```bash
terraform destroy
```
or use:

```bash
terraform destroy -target <name of the ec2 instance>

```
to terminate a specific ec2 instance. 
