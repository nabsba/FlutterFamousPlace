export type ReturnTokenArgs = {
  id: string;
  email: string;
  userName: string;
  provider: string;
  providerAccountId: string;
};

export type VerifyToken = {
  token: string;
};
