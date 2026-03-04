require("dotenv").config();
const { Client } = require("pg");

const client = new Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: {
    rejectUnauthorized: false, // required if using Cloud SQL public IP
  },
});

async function createSchemaAndTable() {
  try {
    await client.connect();

    // Create schema
    await client.query(`
      CREATE SCHEMA IF NOT EXISTS clec;
    `);

    // Create table
    await client.query(`
      CREATE TABLE IF NOT EXISTS clec.directory_listing (
        phone_number VARCHAR(20) PRIMARY KEY,
        first_name VARCHAR(100),
        last_name VARCHAR(100),
        email VARCHAR(150),
        address TEXT,
        city VARCHAR(100),
        state VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    console.log("Schema and table created successfully.");
  } catch (err) {
    console.error("Error:", err);
  } finally {
    await client.end();
  }
}

createSchemaAndTable();
