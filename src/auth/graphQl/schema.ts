import { gql } from 'apollo-server';

const typeDefsAuth = gql`

type Token {
  token: String # Token returned upon successful login
}

  type AuthResponse {
    status: Int! # Status code, e.g., 200 for success, 400 for failure
    isError: Boolean! # Indicates if an error occurred
    messageKey: String! # Message that provides additional information
    data: Token
  }
  input RegisterUserInput {
    id: String!
    provider: String!
    email: String!
    userName: String!
    type: String!
    providerAccountId: String!
  }
  
  type Query {
    login(userName: String!, password: String!): AuthResponse
  }

  type Mutation {
    registerUser(data: RegisterUserInput!): AuthResponse
    registerUserWithCookie(data: RegisterUserInput!): AuthResponse
  }
`;

module.exports = typeDefsAuth;

export default typeDefsAuth;
