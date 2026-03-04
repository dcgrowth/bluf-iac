resource "postgresql_schema" "yellowpage" {
  name     = "yellowpage"
  database = "bluf_dlm"
}

resource "postgresql_table" "directory" {
  name   = "directory"
  schema = postgresql_schema.yellowpage.name

  columns = [
    {
      name = "phone_number"
      type = "VARCHAR(20)"
    },
    {
      name = "first_name"
      type = "VARCHAR(50)"
    },
    {
      name = "last_name"
      type = "VARCHAR(50)"
    },
    {
      name = "email"
      type = "VARCHAR(100)"
    },
    {
      name = "address"
      type = "VARCHAR(255)"
    },
    {
      name = "city"
      type = "VARCHAR(50)"
    },
    {
      name = "state"
      type = "VARCHAR(50)"
    },
    {
      name = "zip_code"
      type = "VARCHAR(10)"
    }
  ]

  primary_key {
    columns = ["phone_number"]
  }
}
