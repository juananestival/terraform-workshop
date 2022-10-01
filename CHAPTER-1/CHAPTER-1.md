# Creating Projects

Create a very basic terraform main.tf file. In the following example we are going to import an existing folder. What I want here is to create a new project in an existing folder. For doing that I will import the already created folder into the terraform state. 

```tf
provider "google" {

}
resource "google_folder" "shared" {
display_name = "Websites"
parent       = "folders/88888888"
}
```

then execute terracorm init to install the provider. This will create a .terraform folder with the dependencies

```sh
terraform init
```
## import existing resources as part of the infra
Now we can  import for example exisitign folders to be part of the infra.
```sh
terraform import google_folder.shared $WORKING_FOLDER
```
This will create an entre in .tfstate. 
Note that the display_name = "Websites" must match with the name of the existing folder

The idea is that when we execute 
```sh
terraform plan
```
We will receive the following messages
"No changes. Your infrastructure matches the configuration."

Import a resource means that id we destroy the infrw we will destroy as well this resource even if it has not been created with terraform. 

In the case that want only refer an exsistin resource but not being part of the infra we call call it as data source. 

## Calling datasources.
To use an existing resource in your gcp you can use data as follows. 
```js
data "google_folder" "shared" {
  folder              = "folders/623561990244"
  lookup_organization = true
 
}
```
if we use modules we can hidratate the module with this data
```js
module "my_project" {
    source = "./modules/target-project"
    project_name = "my-new-project"
    target_folder = data.google_folder.shared
}
```

inside the module
```js
resource "google_project" "my_project" {
  name       = "My Project 2"
  project_id = "juananestival-project-web2"
  folder_id  = var.target_folder.id
}
```
 

## use of modules
create a directory as modules/nameofmodule 
from the root main.tf we can call the module
```js
module "my_project" {
    source = "./modules/target-project"
    project_name = "my-new-project"
    target_folder = data.google_folder.shared
}
```

The module will 
```js
resource "google_project" "my_project" {
  name       = "My Project 2"
  project_id = "juananestival-project-web2"
  folder_id  = var.target_folder.id
}
```

