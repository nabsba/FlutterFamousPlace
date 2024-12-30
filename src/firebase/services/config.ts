const admin = require('firebase-admin');

const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: 'gs://famousplacessba.firebasestorage.app',
});

const bucket = admin.storage().bucket();

export { bucket };
