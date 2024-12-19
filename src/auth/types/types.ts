export type LoginArgs = {
  userName: string;
  password: string;
};

export type RegisterArgs = {
  userName: string;
  password: string;
};
export type registerUser = {
data: {
  id: string;
  provider: string;
  email: string;
  userName: string;
  providerAccountId: string;
  type: string;
}
};
