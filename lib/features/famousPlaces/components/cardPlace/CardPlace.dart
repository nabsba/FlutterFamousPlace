import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/components/cardPlace/DescriptionCard.dart';
import 'package:flutter_svg/svg.dart';

class CardPlace extends StatelessWidget {
  final String? backgroundImage;
  final String name;
  final String location;
  final String country;
  final int rating;

  const CardPlace({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.location,
    required this.country,
    required this.rating,
  });
  void increasePopularity() {
    print('increase');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.65, // Set the width to 70%
      decoration: BoxDecoration(
        image: DecorationImage(
          image: backgroundImage is String
              ? NetworkImage(backgroundImage!)
              : AssetImage("assets/images/No_Image_Available.jpg")
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(
                102, 29, 29, 29), // Semi-transparent black shadow
            offset: Offset(0, 5), // Horizontal and vertical offset
            blurRadius: 9, // Spread of the shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out widgets
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align widgets to the start
        children: [
          // IconHeart widget at the top
          Align(
              alignment:
                  Alignment.topRight, // Position the heart icon at the top-left
              child: Container(
                width: 50, // Diameter of the circle
                height: 50,
                margin: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10), // Diameter of the circle
                decoration: BoxDecoration(
                  color: Colors.grey, // Background color
                  shape: BoxShape.circle, // Circular shape
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      increasePopularity();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/divers/heart.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              )),
          // DescriptionCard at the bottom
          Align(
            alignment: Alignment
                .bottomLeft, // Position DescriptionCard at the bottom-left
            child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(
                  8.0), // Add padding for spacing inside the background
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 30, 59)
                    // ignore: deprecated_member_use
                    .withOpacity(0.9), // Background color without the # prefix
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: DescriptionCard(
                name: name,
                location: location,
                country: country,
                rating: rating,
              ),
            ),
          )
        ],
      ),
    );
  }
}
