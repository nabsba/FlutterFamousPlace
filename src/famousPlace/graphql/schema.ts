import { gql } from 'apollo-server';

// GraphQL schema using gql template literal
const typeDefsPlaces = gql`
  type Place {
    id: String # ID field of type String (from TypeScript definition)
    popularity: Int # Popularity field of type Int
    address: Address # Address field related to Address type
    placeDetail: [PlaceDetail] # A list of PlaceDetails related to the Place
    images: [String!]!
  }

  # GraphQL type definition for Address
  type Address {
    number: Int
    street: String
    postcode: String
    city: City
  }

  # GraphQL type definition for City
  type City {
    name: String
    country: Country
  }

  # GraphQL type definition for Country
  type Country {
    name: String
  }

  # GraphQL type definition for PlaceDetail
  type PlaceDetail {
    name: String
    description: String
  }

  # Queries for fetching places
  type Query {
    places(language: String): [Place]
  }
  input CreatePlace {
    name: String!
    description: String
  }
  # Mutations for manipulating Place
  type Mutation {
    createPlace(input: CreatePlace): Place
    deletePlace(id: Int): Place
  }
`;

export default typeDefsPlaces;
