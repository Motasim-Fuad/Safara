import 'package:flutter/material.dart';
import '../Model/Place.dart';

class CardScreen extends StatelessWidget {
  static const ro = "card";
  final List<Place> places;

  const CardScreen({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: places.isEmpty
          ? Center(child: Text("Your cart is empty!"))
          : ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(place.imgurl, height: 50, width: 50),
              title: Text(place.title),
              subtitle: Text('\$${place.price}'),
              trailing: Icon(Icons.remove_circle, color: Colors.red),
              onTap: () {

              },
            ),
          );
        },
      ),
    );
  }
}
