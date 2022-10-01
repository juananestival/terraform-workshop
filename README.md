# Basics of terraform and the use with gcloud
## gcloud cli tips

```sh
gcloud organizations list
```
This returns name and id
```sh
DISPLAY_NAME                     ID  DIRECTORY_CUSTOMER_ID
your-org  555555555              ndo9dno3
```
List the folders
```sh
gcloud resource-manager folders list --organization 555555555
```

To list a subfolder of a folder
```sh
gcloud resource-manager folders list --folder=555555555
```

## json format
```sh
gcloud resource-manager folders list --folder=555555555 --format=json
```

extracta vaule 
```sh
gcloud resource-manager folders list --folder=555555555 --format=json | grep name |  awk -F' ' '{print $2}' | awk -F'"' '{print $2}'
folders/555555555
```
another way to get only the id

```sh
gcloud resource-manager folders list --folder=634653296365 --format=json | grep name |  awk -F' ' '{print $2}' | awk -F'"' '{print $2}' | sed 's|folders/||'
```


```sh
export WORKING_FOLDER=$(gcloud resource-manager folders list --folder=634653296365 --format=json | grep name |  awk -F' ' '{print $2}' | awk -F'"' '{print $2}' | sed 's|folders/||')
```

## Basic terraform concepts

### Terraform vars
variables.tf will declare variables. 
```js

variable "project" {
	default = "this-is-my-project"
}
```
they can have empty values
```js
## these areguments will be needed. We can't default them
variable "project" {}
variable "function_name" {}
variable "function_entry_point" {}
```

file.tfvar setup of overwrite variables values
```js
project = "new-project value"
```
execute wit vars
```sh
terraform plan -var-file="file.tfvar"
```

### Terraform modules
There subdirectories. Typlically created as follows
modules/whatever