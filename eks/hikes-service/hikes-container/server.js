const app = require('express')()
const os = require('os');
const axios = require("axios").default;
const port = 80

function trimJson(jsonObject) {
  var newJsonObject = [];
  jsonObject.Items.forEach((element) => {
    newJsonObject.push({
      title: element.Detail.en.Title,
      about: element.Detail.en.BaseText,
    });
  });

  return newJsonObject;
}

app.get('/', (req, res) => {
  axios
    .get(
      "http://tourism.opendatahub.bz.it/api/Activity?language=en&pagenumber=1&pagesize=10&activitytype=16&latitude=46.49067&longitude=11.33982"
    )
    .then(function (response) {
      console.log("Parsed OpenDataHUB URL: " + response.config.url);
      try {
        res.json(trimJson(response.data));
      } catch (error) {
        res.send("Something went wrong at ActivityAPI.js");
      }
    })
    .catch(function (error) {
      // handle error
      console.log(error);
      res.send("Something went wrong at ActivityAPI.js");
    })
    .then(function () {
      console.log("ActivityAPI - GET /ActivitiesAroundBolzano executed");
    });
});


app.listen(port, () => console.log(`listening on port ${port}`));