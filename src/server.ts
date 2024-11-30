import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();

app.get('/', (_, res) => {
  res.send('Example Server');
});

const port: number = process.env.PORT ? parseInt(process.env.PORT) : 5000;
app.listen(port, () => console.log(`🚀 Server ready at http://localhost:${port}`));

/*
go to localhost:4000/graphql and then run this. It does not work like rest where you fetch a specific route localhost:4000/dogs but instead of the system through graphql that avoid all those routes.
query {
  dogs {
    id
    name
    owner
  }
}
*/

// route bellow replaced with graphQL

// app.get('/', (req: Request, res: Response): void => {
//   res.send('Hello, world!');
// });
// app.use('/api', dogRoutes);

// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });

// checks for user in cookies and adds userId to the requests
// const { token } = req.cookies;
// if (token) {
//   const { userId } = jwt.verify(token, process.env.USER_SECRET);
//   req.userId = userId;
