data "google_sql_database_instance" "bluf2020" {
  name = "bluf2020"
}

resource "google_sql_database" "bluf_dlm" {
  name     = "bluf_dlm"
  instance = data.google_sql_database_instance.bluf2020.name
}


