import { gql } from 'apollo-server';

const typeDefsJWT = gql`

type RefreshToken {
  token: String # Token returned upon successful login
}

input RegisterUserInput {
  id: String!
  provider: String!
  email: String!
  userName: String!
  type: String!
  providerAccountId: String!
}

  type Response {
    status: Int! # Status code, e.g., 200 for success, 400 for failure
    isError: Boolean! # Indicates if an error occurred
    messageKey: String! # Message that provides additional information
    data: RefreshToken
  }
  type Mutation {
    refreshToken(data: RegisterUserInput!): Response
   
  }
`;

module.exports = typeDefsJWT;

export default typeDefsJWT;
