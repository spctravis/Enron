const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();

// Middleware to handle form data
app.use(bodyParser.urlencoded({ extended: true }));

// Connect to your PostgreSQL database
const pool = new Pool({
  user: 'your_username',
  host: 'localhost',
  database: 'your_database',
  password: 'your_password',
  port: 5432,
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Query your database to authenticate the user
  pool.query('SELECT * FROM users WHERE username = $1 AND password = $2', [username, password], (error, results) => {
    if (error) {
      throw error;
    }

    // If user is found and password matches
    if (results.rows.length > 0) {
      res.send('Logged in successfully');
    } else {
      res.send('Invalid username or password');
    }
  });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});