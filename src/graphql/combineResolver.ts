import { resolversAuth } from '../auth/graphQl/resolver';
import { resolversPlace } from '../famousPlace';
import { resolversJWT } from '../jwt';

const resolvers = {
  Query: {
    ...resolversPlace.Query,
    ...resolversAuth.Query,
  },
  Mutation: {
    ...resolversPlace.Mutation,
    ...resolversAuth.Mutation,
    ...resolversJWT.Mutation,
  },
};

export { resolvers };
