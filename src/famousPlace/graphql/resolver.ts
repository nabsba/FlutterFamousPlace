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
import { handleAddPlaceToPreference, handleGetPlace, handleGetPlaces, handleGetPreSelectionName } from '../services/functions';
import { CreatePlace, FavoritePlaceBody, PlaceBody, PlacesBody, PreSelectionBody } from '../type';

export const resolversPlace = {
  Query: {
    place: async (_parent: any, args: PlaceBody, _context: any) => {
      try {
        const result = await handleGetPlace(args);

        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.GET_PLACE,
          data: result
        };
      } catch (error) {
        logMessage(`${logErrorAsyncMessage('famousPlace/graphql/resolversPlace', `${ERROR_MESSAGES.GET_PLACE}:`)},
         ${error}`);
        return {
          status: STATUS_SERVER.SERVER_ERROR,
          isError: true,
          messageKey: ERROR_MESSAGES_KEYS.GET_PLACES,
        };
      }
    },
    places: async (_parent: any, args: PlacesBody, _context: any) => {
      try {
        const result = await handleGetPlaces(args);
        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.GET_PLACES,
          data: result
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
    preselectionName: async (_parent: any, args: PreSelectionBody, _context: any) => {
      try {
        const result = await handleGetPreSelectionName(args);
  
        return {
          status: SUCCESS_STATUS.OK,
          isError: false,
          messageKey: SUCCESS_MESSAGES_KEYS.GET_PRESELECTION_NAMES,
          data: {
            selections:result
          }
        };
      } catch (error) {
        logMessage(`${logErrorAsyncMessage('famousPlace/graphql/resolversPlace', `${ERROR_MESSAGES.GET_PRESELECTION_NAMES}:`)},
         ${error}`);
        return {
          status: STATUS_SERVER.SERVER_ERROR,
          isError: true,
          messageKey: ERROR_MESSAGES_KEYS.GET_PRESELECTION_NAMES,
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
