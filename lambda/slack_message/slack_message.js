const https = require("https");
const url = require("url");

const SLACK_WEBHOOK_URI = process.env.SLACK_WEBHOOK_URI || "";

exports.handler = async (event) => {
  const slackOptions = url.parse(SLACK_WEBHOOK_URI);
  slackOptions.method = "POST";
  slackOptions.headers = {
    "Content-Type": "application/json"
  };

  const records = event.Records || [];
  return Promise.all(records.map(async (record) => {
    if (record.Sns) {
      try {
        const slackMessage = JSON.stringify({ text: record.Sns.Message });
        await toSlack(slackOptions, slackMessage);
      } catch(e) {
        throw e;
      }
    }
  }));
};

function toSlack(opts, msg){
  return new Promise((resolve, reject) => {
    const req = https.request(opts, (res) => {
      if (res.statusCode < 200 || res.statusCode >= 300) {
        return reject(new Error(res.statusCode));
      }

      res.on("end", () => {
        resolve(res);
      });
    });

    req.on("error", (err) => {
      reject(err);
    });

    req.write(msg);
    req.end();
  });
};
