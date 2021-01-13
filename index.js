const admin = require("firebase-admin");
const express = require("express");
const bodyParser = require("body-parser");
const serviceAccount = require("./presto.json");
const router = express.Router();

const fastcsv = require("fast-csv");
const fs = require("fs");
const file = fs.createWriteStream("user.csv");

const app = express();
app.use(bodyParser.json());

const notification_options = {
  priority: "high",
  timeToLive: 60 * 60 * 24,
};

//initialize admin SDK using serciceAcountKey
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://presto-3013d.firebaseio.com",
});

const db = admin.firestore();
const port = 3000;

getCSVFile().then((result) => {
  console.log(result);
});

function getCSVFile() {
  const data = db.collection("users");
  return data
    .get()
    .then((querySnapshot) => {
      var object = {};
      var jsondata = [];
      querySnapshot.forEach((doc) => {
        object = doc.data();
        jsondata.push(object);
      });
      // console.log(jsondata);
      fastcsv.write(jsondata, { headers: true }).pipe(file);
    })
    .catch((err) => {
      return console.log(err);
    });
}

app.post("/firebase/notification/", (req, res) => {
  const userCode = req.body.code;
  console.log(userCode);

  const message = {
    notification: {
      title: "username",
      body: "Want to go in your cab",
    },
  };
  const options = notification_options;

  const data = db.collection("users");
  data.doc(userCode)
    .get()
    .then((snapshot) => {
      var object = {};
      object = snapshot.data()["jsonData"];
      console.log(object);
      var jsonObject = JSON.parse(object);
      var referredTo = jsonObject["referredTo"];
      console.log(referredTo);
      referredTo.forEach((id) => {
        const data = db.collection("users");
        data.doc(id)
          .get().then((snapshot) => {
            var user = snapshot.data()["jsonData"];
            var json = JSON.parse(user);
            var token = json["notificationToken"];
            console.log(token);
            admin
            .messaging()
            .sendToDevice(token, message, options)
            .then((response) => {
              res.status(200).send("Notification sent successfully");
            })
            .catch((error) => {
              console.log(error);
            });
          });
      });
    });
});

app.post("/creditScoring/:userId", (req, res) => {
  const id = req.params.userId;
  var currentUserId = id;
  var i = 1;
  while (i <= 5) {
    const userData = db.collection("users").doc(currentUserId).get();
    var score = userData.data()["creditScore"];
    score -= i * 0.05;
    db.collection("users").doc(currentUserId).update({
      "creditScore": score
    }).then(() => {
      currentUserId = userData.data()["id"];
      i = i + 1;
    });
  }
});

app.listen(port, () => {
  console.log("listening to port " + port);
});
