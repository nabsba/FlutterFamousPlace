import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/placeDetail/components/DescriptionDetail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/home/home.dart';
import '../services/DescriptionCard.dart';

class ImageAndDetail extends StatelessWidget {
  final String? imageUrl;
  final DescriptionDetailArgument descriptionDetailArgument;

  const ImageAndDetail({
    required this.imageUrl,
    required this.descriptionDetailArgument,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 70.0), // Add top margin here
        child: Stack(
          children: [
            // Background Image
            Container(
              width: MediaQuery.of(context).size.width * 0.860,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageUrl is String
                      ? NetworkImage(imageUrl!)
                      : AssetImage("assets/images/No_Image_Available.jpg")
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(102, 29, 29, 29),
                    offset: Offset(0, 5),
                    blurRadius: 9,
                  ),
                ],
              ),
            ),

            // Icons at the top
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.02, // 2% of the screen height
              left: MediaQuery.of(context).size.width *
                  0.1, // 10% of the screen width
              right: MediaQuery.of(context).size.width *
                  0.1, // 10% of the screen width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 45, // Adjust to fit the circle's size
                      height: 45, // Ensure it's a perfect square
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey, // Set the background colour to grey
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.canPop(context)
                              ? context
                                  .pop() // Pop the current screen if possible
                              : context.go(HomePage
                                  .routeName), // Pop the current screen if possible
                          // This will pop the current screen from the navigation stack
                        ),
                      )),
                  Container(
                    width: 45, // Adjust to fit the circle's size
                    height: 45, // Ensure it's a perfect square
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Set the background colour to grey
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/divers/mark.svg',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Menu at the bottom
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 30, 59).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DescriptionDetail(
                    descriptionDetailArgument: descriptionDetailArgument,
                  )),
            ),
          ],
        ));
  }
}
