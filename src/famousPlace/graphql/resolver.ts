import prismaClientDB from '../../lib/prismadb';
import { CreatePlace } from '../type';

export const resolversPlace = {
  Query: {
    places: async (_parent: any, args: any, _context: any) => {
      const { language } = args;
      return await prismaClientDB.place.findMany({
        include: {
          address: {
            include: {
              city: {
                include: {
                  country: true,
                },
              },
            },
          },
          placeDetail: {
            where: {
              languageId: language ? parseInt(language) : 1, // assuming 1 is the language ID for English
            },
          },
        },
      });
    },
  },
  Mutation: {
    createPlace: async (input: CreatePlace) => {
      return true;
    },

    deletePlace: async (_: any, { id }: { id: string }) => {
      return prismaClientDB.place.delete({ where: { id } });
    },
  },
};
