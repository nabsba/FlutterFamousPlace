import prismaClientDB from '../../lib/prismadb';

async function main() {
  // France
  const clientRole = await prismaClientDB.role.create({
    data: {
      // Generate a unique ID for the role
      roleName: 'client',
    },
  });
  const languages = await prismaClientDB.language.createMany({
    data: [{ type: 'eng' }, { type: 'fr' }],
    skipDuplicates: true, // Optional: skips rows if they already exist
  });
  const hotelData = await prismaClientDB.place.create({
    data: {
      popularity: 10,
      image: 'hotel_de_paris_monte-Carlo', // A high value assuming it's a popular place
      address: {
        create: {
          number: 1, // Assuming number is "1" for simplicity
          street: 'Place du Casino',
          postcode: '98000',
          city: {
            create: {
              name: 'Monaco',
              country: {
                create: {
                  name: 'France',
                },
              },
            },
          },
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Hôtel de Paris Monte-Carlo',
            description: `Le majestueux Hôtel de Paris Monte-Carlo se dresse sur la place du Casino, avec le magnifique Palais Princier et la Méditerranée en toile de fond. Son emplacement privilégié, ses intérieurs contemporains récemment rénovés et son service ultra-personnalisé inspirent la détente, l'harmonie et le bien-être. C'est ici que vous pourrez créer votre propre histoire. L'hôtel abrite également l'un des meilleurs restaurants au monde, Le Louis XV - Alain Ducasse à l'Hôtel de Paris Monte-Carlo, qui élève la cuisine de la Riviera à un tout autre niveau exquis, en l'élevant avec les meilleurs ingrédients, des saveurs authentiques et appétissantes et une exécution sans faille. Le Grill a été créé pour exaucer le souhait de Maria Callas de dîner avec vue sur trois pays à la fois. Il y a également une rôtisserie de renommée mondiale et un toit-terrasse coulissant. Le Bar American est l'endroit idéal pour se mêler au glamour clinquant de Monaco, profiter de la musique live et savourer des cocktails originaux et intemporels.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Hotel de Paris Monte-Carlo',
            description: `The majestic Hôtel de Paris Monte-Carlo is set like a breathtaking tableau on the Casino Square, with the scenic Prince’s Palace and Mediterranean as a backdrop. Its prime location, newly refurbished Contemporary interiors, and ultra-personalized service inspire relaxation, harmony, and well-being. Here is the stage to create your own story. The hotel is also home to one of the world’s premier restaurants, Le Louis XV - Alain Ducasse à l'Hôtel de Paris Monte-Carlo, which takes Riviera cuisine to a whole new exquisite level, elevating it with the finest ingredients, authentic, mouthwatering flavors, and flawless execution. Le Grill was established to fulfill a wish of Maria Callas’ to dine overlooking three countries at once. There is also a world-famous rotisserie and sliding rooftop. Le Bar American is the place to mingle with the glitzy glam of Monaco, enjoy live music, and savor original, timeless cocktails.`,
            languageId: 1, // Another language ID (e.g., English)
          },
        ],
      },
    },
  });
  const colosseumData = await prismaClientDB.place.create({
    data: {
      popularity: 10,
      image: 'colosseum', // A high value assuming it's a popular place
      address: {
        create: {
          number: 1, // Assuming number is "1" for simplicity
          street: 'Piazza del Colosseo',
          postcode: '00184',
          city: {
            create: {
              name: 'Rome',
              country: {
                create: {
                  name: 'Italy',
                },
              },
            },
          },
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Colosseum',
            description: `Le Colisée est un amphithéâtre romain antique situé au centre de Rome, en Italie. Construit sous les empereurs Flaviens, il est le plus grand amphithéâtre jamais construit et reste une attraction touristique majeure, représentant le riche patrimoine historique de Rome.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Colosseum',
            description: `The Colosseum is an ancient Roman amphitheatre located in the center of Rome, Italy. Built during the Flavian emperors, it is the largest amphitheatre ever built and remains a major tourist attraction, showcasing Rome's rich historical heritage.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
  const leaningTowerData = await prismaClientDB.place.create({
    data: {
      popularity: 9, // Another popular place, but slightly less than the Colosseum
      image: 'piazza_del_duomo',
      address: {
        create: {
          number: 1, // Assuming number is "1" for simplicity
          street: 'Piazza del Duomo',
          postcode: '56126',
          city: {
            create: {
              name: 'Pisa',
              countryId: 2,
            },
          },
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Tour penchée de Pise',
            description: `La Tour penchée de Pise, communément appelée la Tour de Pise, est l'un des monuments les plus célèbres d'Italie. Située sur la Piazza del Duomo à Pise, elle est célèbre pour son inclinaison caractéristique.`,

            languageId: 2,
          },
          {
            name: 'Leaning Tower of Pisa',
            description: `The Leaning Tower of Pisa is one of Italy's most iconic landmarks. Located in the Piazza del Duomo in Pisa, it is famous for its characteristic tilt.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
  const bigBenData = await prismaClientDB.place.create({
    data: {
      popularity: 10, // A popular landmark in England
      image: 'big_ben',
      address: {
        create: {
          number: 1, // Assuming "1" as a placeholder
          street: 'Westminster',
          postcode: 'SW1A 0AA',
          city: {
            create: {
              name: 'London',
              country: {
                create: {
                  name: 'England',
                },
              },
            },
          },
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Big Ben',
            description: `Big Ben est l'un des monuments les plus emblématiques de Londres et du Royaume-Uni. Située à l'extrémité nord du palais de Westminster, cette tour de l'horloge est un symbole mondialement connu.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Big Ben',
            description: `Big Ben is one of the most iconic landmarks in London and the United Kingdom. Located at the north end of the Palace of Westminster, this clock tower is a globally recognised symbol.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
  const stonehengeData = await prismaClientDB.place.create({
    data: {
      popularity: 9, // A highly popular historical site
      image: 'stonehenge',
      address: {
        create: {
          number: 1, // Placeholder number
          street: 'Stonehenge',
          postcode: 'SP4 7DE',
          city: {
            create: {
              name: 'Amesbury',
              countryId: 3,
            },
          },
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Stonehenge',
            description: `Stonehenge est l'un des monuments préhistoriques les plus célèbres au monde. Situé dans la plaine de Salisbury, il est composé d'un cercle de grandes pierres dressées datant d'environ 2500 avant J.-C.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Stonehenge',
            description: `Stonehenge is one of the most famous prehistoric monuments in the world. Located on Salisbury Plain, it consists of a ring of massive standing stones dating back to around 2500 BC.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
  const towerBridgeData = await prismaClientDB.place.create({
    data: {
      popularity: 9, // A major landmark in London
      image: 'tower_bridge',
      address: {
        create: {
          number: 1, // Placeholder number
          street: 'Tower Bridge Road',
          postcode: 'SE1 2UP',
          cityId: 4,
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Tower Bridge',
            description: `Tower Bridge est un pont emblématique de Londres, traversant la Tamise. Il est célèbre pour son architecture victorien et son mécanisme de levée permettant aux navires de passer sous le pont.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Tower Bridge',
            description: `Tower Bridge is an iconic bridge in London, spanning the River Thames. It is famous for its Victorian architecture and its lifting mechanism that allows ships to pass beneath the bridge.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
  const buckinghamPalaceData = await prismaClientDB.place.create({
    data: {
      popularity: 10, // A major landmark in London
      image: 'buckingham_palace',
      address: {
        create: {
          number: 1, // Placeholder number
          street: 'Buckingham Palace Road',
          postcode: 'SW1A 1AA',
          cityId: 4, // Assuming London city ID is 4
        },
      },
      placeDetail: {
        create: [
          {
            name: 'Buckingham Palace',
            description: `Buckingham Palace est la résidence officielle de la Reine à Londres. Ce palais emblématique est connu pour sa façade imposante, ses jardins et la célèbre relève de la garde.`,
            languageId: 2, // French language ID
          },
          {
            name: 'Buckingham Palace',
            description: `Buckingham Palace is the official residence of the Queen in London. This iconic palace is known for its grand facade, gardens, and the famous Changing of the Guard ceremony.`,
            languageId: 1, // English language ID
          },
        ],
      },
    },
  });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prismaClientDB.$disconnect();
  });
