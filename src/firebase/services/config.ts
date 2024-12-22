var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: "gs://famousplacessba.firebasestorage.app", 

});


var bucket = admin.storage().bucket();

export {bucket}