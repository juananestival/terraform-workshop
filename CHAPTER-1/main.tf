provider "google" {}

data "google_folder" "shared" {
  folder              = var.target_folder
  lookup_organization = true
}

module "my_project" {
    source = "./modules/target-project"
    project_name = var.project_name
    project_id = var.project_id
    target_folder = data.google_folder.shared
}