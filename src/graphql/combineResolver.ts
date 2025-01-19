import { Query } from './../famousPlace/type';
import { resolversAuth } from '../auth/graphQl/resolver';
import { resolversPlace } from '../famousPlace';
import { resolversJWT } from '../jwt';
import { resolverWeather } from '../fakeApiMeteo/graphql/resolver';

const resolvers = {
  Query: {
    ...resolversPlace.Query,
    ...resolversAuth.Query,
    ...resolverWeather.Query
  },
  Mutation: {
    ...resolversPlace.Mutation,
    ...resolversAuth.Mutation,
    ...resolversJWT.Mutation,
  },
};

export { resolvers };
