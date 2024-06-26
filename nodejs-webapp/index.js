const express = require('express');
const app = express();
const port = process.env.PORT || 3001;

app.get('/', (req, res) => {
  res.send('Tootmiskeskkond');
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

module.exports = app;
