import * as admin from 'firebase-admin';
import  serviceAccount from './serviceAccountKey.json';
const serviceAccountCreds = serviceAccount as admin.ServiceAccount;
admin.initializeApp({
  credential: admin.credential.cert(serviceAccountCreds),
  storageBucket: 'gs://famousplacessba.firebasestorage.app',
});

const bucket = admin.storage().bucket();

export { bucket };
