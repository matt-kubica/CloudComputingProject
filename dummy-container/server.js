const app = require('express')()
const os = require('os');
const port = 80


app.get('/', (req, res) => {
  res.send({
    arch: os.arch(),
    hostname: os.hostname(),
    platform: os.platform(),
    uptime: os.uptime(),
  });
});

app.listen(port, () => console.log(`listening on port ${port}`));