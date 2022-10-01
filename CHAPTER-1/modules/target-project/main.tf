resource "google_project" "my_project" {
  name       = var.project_name
  project_id = var.project_id
  folder_id  = var.target_folder.id
}
