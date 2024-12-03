import { resolversPlace } from "../famousPlace";


const resolvers = {
    Query: {
      ...resolversPlace.Query,

    },
    Mutation: {
      ...resolversPlace.Mutation,

    },
  };


  export {resolvers}