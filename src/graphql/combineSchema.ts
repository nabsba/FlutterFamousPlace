import typeDefsAuth from '../auth/graphQl/schema';
import { typeDefsPlaces } from '../famousPlace';
import { typeDefsJWT } from '../jwt';

export const typeDefs = [typeDefsPlaces, typeDefsAuth, typeDefsJWT];
