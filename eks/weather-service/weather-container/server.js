const app = require('express')()
const os = require('os');
const axios = require("axios").default;
const port = 80

function trimJson(jsonObject) {
  //delete unnecesssary fields
  console.log("trimJson: " + jsonObject.Id);
  ["Id", "date", "evolutiontitle", "evolution", "Mountain"].forEach(
    (e) => delete jsonObject[e]
  );

  var i = jsonObject.Stationdata.length;
  while (i--) {
    if (jsonObject.Stationdata[i].CityName != "Bolzano / Bozen") {
      jsonObject.Stationdata.splice(i, 1);
    }
  }
}

app.get('/', (req, res) => {
  axios
    .get("http://tourism.opendatahub.bz.it/api/Weather?language=en")
    .then(function (response) {
      // handle success
      console.log(response.config.url);
      try {
        trimJson(response.data);
        res.json(response.data);
      } catch (error) {
        res.send("Something went wrong at WeatherAPI.js");
      }
    })
    .catch(function (error) {
      // handle error
      console.log(error);
      res.send("Something went wrong at WeatherAPI.js");
    })
    .then(function () {
      console.log("WeatherAPI - GET /Weather executed");
    });
});


app.listen(port, () => console.log(`listening on port ${port}`));