import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final double rating;
  final String countryName;

  const CustomCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.6;
    if (cardWidth > 350) cardWidth = 350;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 4),
                  Text("Price: $price",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.green)
                  ),
                  const SizedBox(height: 4),
                  Text("Rating: ⭐ $rating",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black54)
                  ),
                  const SizedBox(height: 4),
                  Text("Country: $countryName",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black54)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
double getResponsiveHeight(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  final orientation = MediaQuery.of(context).orientation;


  if (width >= 1200) {

    return height * 0.6;
  } else if (width >= 900) {

    return height * 0.7;
  } else if (width >= 600) {

    return height * 0.75;
  } else if (width >= 400) {

    return height * 0.7;
  } else if (width >= 300) {

    return height * 0.6;
  } else {

    return height * 0.5;
  }
}
