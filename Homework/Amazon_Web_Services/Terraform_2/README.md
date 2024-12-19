### 🛠️ Task: Terraform Module and Backend Setup
#### Create a Terraform module that takes the following input values:

- 🏗️ vpc_id
- 🔓 list_of_open_ports

#### In the eu-north-1 region, the module should:

- 🔐 Create a security group that allows access from anywhere to the specified ports in the given VPC
- 💻 Create a public EC2 instance in the specified VPC with a default Nginx server or Nginx running in a container

#### Outputs:

- 🌐 IP of the created instance
- 🌍 Use http://IP to confirm that Nginx is running

#### Backend Configuration:

- 🗄️ Configure S3 backend for your project
- 📦 Use the terraform-state-danit-devops-2 bucket in the eu-central-1 region
- 🛠️ Configure a unique path for your state using your login name
- ✔️ Ensure the file is created in the bucket and gets updated when you change the infrastructure

