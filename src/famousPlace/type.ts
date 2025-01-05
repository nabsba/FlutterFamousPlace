// type.ts
export type Address = {
  number: number;
  street: string;
  postcode: string;
  city: City;
};

export type City = {
  name: string;
  country: Country;
};

export type Country = {
  name: string;
};

export type PlaceDetail = {
  name: string;
  description: string;
};

export type Place = {
  id: string; // Assuming it's a `cuid` generated string ID
  popularity: number;
  address: Address;
  placeDetail: PlaceDetail[];
};

export type Query = {
  places: Place[];
};

export type CreatePlace = {
  name: string;
  description: string;
};

export type FavoritePlaceBody = {
  placeId: string;
  userId: string;
};
export type PlacesBody = { language: string; type: string; userId: string, page: string };
export type PreSelectionBody = { language: string; type: string; userId: string, text: string };
