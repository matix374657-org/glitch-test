const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello, Glitch!');
});

app.listen(port, () => {
  console.log(`App is running on port ${port}`);
});