import 'package:flutter/material.dart';

class ImageAndDetail extends StatelessWidget {
  final String? imageUrl;
  final IconData iconLeft;
  final IconData iconRight;
  final List<String> menuItems;

  const ImageAndDetail({
    required this.imageUrl,
    required this.iconLeft,
    required this.iconRight,
    required this.menuItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Center(
          child: Container(
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
        ),

        // Icons at the top
        Positioned(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(iconLeft, color: Colors.white, size: 32.0),
              Icon(iconRight, color: Colors.white, size: 32.0),
            ],
          ),
        ),
        // Menu at the bottom
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: menuItems.map((item) {
                return Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
