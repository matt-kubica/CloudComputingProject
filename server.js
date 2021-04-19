const express = require('express')
const axios = require('axios').default;
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
  axios.get('http://tourism.opendatahub.bz.it/api/Location?language=en&type=null&showall=true&locfilter=null')
  .then(function (response) {
    // handle success
    console.log(response.config.url);
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
  .then(function () {
    console.log("server.js - app.get / executed")
  });
})

app.listen(port, () => {
  console.log(`server.js listening at http://localhost:${port}`)
})