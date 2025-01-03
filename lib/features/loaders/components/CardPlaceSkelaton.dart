import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardPlaceSkeleton extends StatelessWidget {
  const CardPlaceSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300, // Base skeleton colour
      highlightColor: Colors.grey.shade100, // Highlight colour for shimmer
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 29),
        width: MediaQuery.of(context).size.width * 0.65,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // Base background for skeleton
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(102, 29, 29, 29),
              offset: const Offset(0, 5),
              blurRadius: 9,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 50,
                height: 50,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
