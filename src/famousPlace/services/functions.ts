import { ERROR_MESSAGES, logErrorAsyncMessage, logMessage, STATUS_SERVER } from '../../common';
import { listFilesInFolder } from '../../firebase';
import prismaClientDB from '../../lib/prismadb';
import { PlacesBody } from '../type';

const handleAddPlaceToPreference = async (placeId: string, userId: string) => {
  try {
      let existingPlace = await prismaClientDB.placeOnUser.findUnique({
        where: {
          userId_placeId: {
            userId: userId,
            placeId: placeId,
          },
        },
      });
      if (existingPlace) {
        existingPlace = await prismaClientDB.placeOnUser.delete({
          where: {
            userId_placeId: {
              userId: userId,
              placeId: placeId,
            },
          },
        });
      } else {
        existingPlace = await prismaClientDB.placeOnUser.create({
          data: {
            userId: userId,
            placeId: placeId,
          },
        });
      }
return existingPlace;
  } catch (error) {
    logMessage(`${logErrorAsyncMessage('src/famousPlace/services/function/handleAddPlaceToPreference', `${ERROR_MESSAGES.ADD_PLACE_TO_PREFERENCE}:`)},
        ${error}`);
        throw error;

  }
};

const handleGetPlaces = async (args: PlacesBody) => {
  try {
    const { language, type, userId  } = args;
    const result = await prismaClientDB.place.findMany({
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
        languageId: language ? parseInt(language) + 1 : 1, // Assuming 1 is the default language ID for English
      },
    },
    _count: {
      select: {
        users: true, // Count the number of related users
      },
    },
    users: {
      where: {
        userId: userId, // Check for the specific userId in PlaceOnUser
      },
      select: {
        userId: true, // Only fetch the `userId` to determine the relationship
      },
    },
  },
});
    const finalResult = [];
    for (let i = 0; i < result.length; i++) {
      const isPlaceOnUser = result[i]._count.users > 0;
      finalResult.push({
        ...result[i],
        placeDetail: result[i].placeDetail[0],
        images: await listFilesInFolder(`${result[i].address.city.name.toLocaleLowerCase()}/${result[i].image}`),
        isFavoritePlace: isPlaceOnUser,
      });
    }
    return finalResult;
  } catch (error) {
    logMessage(`${logErrorAsyncMessage('src/famousPlace/services/function/handleGetPlaces', `${ERROR_MESSAGES.REGISTER_USER}:`)},
    ${error}`);
    throw error;
  }
};


export { handleAddPlaceToPreference, handleGetPlaces };