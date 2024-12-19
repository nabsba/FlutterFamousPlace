import { ApolloServer } from 'apollo-server-express';
import express from 'express';
import { resolvers, typeDefs } from './graphql';
import cors from 'cors';
require('dotenv').config();
const app = express() as any;
app.get('/', (_: any, res: { send: (arg0: string) => void }) => {
  res.send('Example Server');
});

const corsOptions = {
  origin: ['https://studio.apollographql.com', 'http://localhost:3000'],
  credentials: true, // <-- REQUIRED backend setting
};
app.use(cors(corsOptions));
// app.use(cookieParser());
app.use((req: any, res: any, next: () => void) => {
  //     let user = null;
  //      if (req.headers && req.headers.authorization) {
  //       const token = req.headers.authorization.replace('Bearer ', '');
  //       try {
  //         user = verifyToken(token); // Assuming this verifies the token and returns user info
  //       } catch (err) {
  //         console.error('Token verification failed', err);
  //       }
  //     }
  // // console.log(req);

  // // }
  next();
});

async function startServer() {
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: async ({ req }) => {},
  });
  await server.start();

  server.applyMiddleware({
    app,
    path: '/',
    cors: false, // disables the apollo-server-express cors to allow the cors middleware use
  });
}

const port: number = process.env.PORT ? parseInt(process.env.PORT) : 4000;

startServer();

app.listen({ port }, () => console.log(`🚀 Server ready at http://localhost:4000`));
