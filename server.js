const express = require('express');
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');
const { Pool } = require('pg');
const path = require('path');

const app = express();

// Middleware to handle form data
app.use(bodyParser.urlencoded({ extended: true }));
app.use(fileUpload());

// Connect to your PostgreSQL database
const pool = new Pool({
  user: 'your_username',
  host: 'localhost',
  database: 'your_database',
  password: 'your_password',
  port: 5432,
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'defaultwebpage.html'));
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

app.post('/upload', function(req, res) {
  let sampleFile;
  let uploadPath;

  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('No files were uploaded.');
  }

  // The name of the input field (i.e. "sampleFile") is used to retrieve the uploaded file
  sampleFile = req.files.sampleFile;
  uploadPath = __dirname + '/uploads/' + sampleFile.name;

  // Use the mv() method to place the file somewhere on your server
  sampleFile.mv(uploadPath, function(err) {
    if (err)
      return res.status(500).send(err);

    res.send(`<html><body>File uploaded! Filename: ${sampleFile.name}</body></html>`);
  });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});