require('appdynamics').profile({
  controllerHostName: process.env.APPD_CONTROLLER_HOST,
  accountName: process.env.APPD_ACCOUNT_NAME,
  accountAccessKey: process.env.APPD_ACCESS_KEY,
  applicationName: process.env.APPD_APP_NAME,
  tierName: process.env.APPD_TIER_NAME,
  nodeName: process.env.APPD_NODE_NAME
});

const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from 32Co DevOps Assessment!');
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
