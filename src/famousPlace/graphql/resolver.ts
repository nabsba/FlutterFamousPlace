import {
  ERROR_MESSAGES,
  ERROR_MESSAGES_KEYS,
  logErrorAsyncMessage,
  logMessage,
  STATUS_SERVER,
  SUCCESS_MESSAGES_KEYS,
  SUCCESS_STATUS,
} from '../../common';
import prismaClientDB from '../../lib/prismadb';
import { handleAddPlaceToPreference, handleGetPlaces } from '../services/functions';
import { CreatePlace, FavoritePlaceBody } from '../type';

export const resolversPlace = {
  Query: {
    places: async (_parent: any, args: any, _context: any) => {
      try {
        const result = await handleGetPlaces(args);
        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.GET_PLACES,
          data: {
            places: result,
          },
        };
      } catch (error) {
        logMessage(`${logErrorAsyncMessage('famousPlace/graphql/resolversPlace', `${ERROR_MESSAGES.GET_PLACES}:`)},
         ${error}`);
        return {
          status: STATUS_SERVER.SERVER_ERROR,
          isError: true,
          messageKey: ERROR_MESSAGES_KEYS.GET_PLACES,
        };
      }
    },
  },
  Mutation: {
    createPlace: async (input: CreatePlace) => {
      return true;
    },
    deletePlace: async (_: any, { id }: { id: string }) => {
      return prismaClientDB.place.delete({ where: { id } });
    },
    toggleFavoritePlace: async (_: any, { placeId, userId }: FavoritePlaceBody) => {
      try {
        const result = await handleAddPlaceToPreference(placeId, userId);

        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.ADD_PLACE_TO_PREFERENCE,
          data: {
            placeId: result.placeId,
          },
        };
      } catch (error) {
        return {
          status: STATUS_SERVER.SERVER_ERROR,
          isError: true,
          messageKey: ERROR_MESSAGES_KEYS.ADD_PLACE_TO_PREFERENCE,
        };
      }
    },
  },
};
