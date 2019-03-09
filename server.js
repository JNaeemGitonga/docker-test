const express = require('express');
const port  = process.env.PORT || 8080;
const path = require('path');
const app = express();

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, './index.html'))
})

app.get('/doc', (req, res) => {
  res.json({message: 'peace'})
})

app.listen(port, () => {
  console.log(__dirname)
  console.log()
  console.log('May the force be with you on server port ' + port);
});