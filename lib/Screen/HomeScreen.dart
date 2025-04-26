import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safara/Screen/Card_Screen.dart';
import 'package:safara/Screen/GetStartScreen.dart';
import 'package:safara/Widgets/circulerIconBtn.dart';
import '../Model/Place.dart';
import '../Widgets/catagoryBtn.dart';
import '../Widgets/coustom_card.dart';

class HomeScreen extends StatefulWidget {
  static const ro = "Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  String selectedCategory = 'All';
  List<Place> filteredCities = place_list;
  List<Place> cartItems = [];




  @override
  void initState() {
    super.initState();
    filteredCities = place_list;
  }

  //  search query
  void filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = place_list;
      } else {
        filteredCities = place_list
            .where((city) =>
            city.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  //  selected category
  void filterCategory(String category) {
    setState(() {
      if (category == 'All') {
        filteredCities = place_list;
      } else {
        filteredCities = place_list
            .where((city) => city.category.toLowerCase() == category.toLowerCase())
            .toList();
      }
    });
  }

  // show dialog

  void _showCardDialog(BuildContext context, Place place) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(place.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(place.imgurl, height: 300, width: 300),
              SizedBox(height: 10),
              Text('Country: ${place.country}'),
              Text('Price: \$${place.price}'),
              Text('Rating: ${place.rating}'),
              Text('Category: ${place.category}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  cartItems.add(place);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${place.title} added to your cart')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App bar section
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome back !", style: TextStyle(fontSize: 15)),
                        Text("Motasim Fuad", style: TextStyle(fontSize: 25)),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.send)),
                    IconButton(
                      splashRadius: 150,
                      splashColor: Colors.grey,
                      onPressed: () {},
                      icon: Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search your favourite destinations",
                      prefixIcon: Icon(Icons.search, color: Colors.yellow),
                      suffixIcon: TextButton(
                        onPressed: () {
                          _controller.clear();

                          setState(() {
                            selectedCategory = 'All';
                            filteredCities = place_list;
                            _controller.clear();
                          });
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.ro,
                                (route) => false,
                          );
                        },
                        child: Icon(Icons.clear),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: filterCities,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Text("Popular Categories", style: TextStyle(fontSize: 30)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'All';
                      });
                      filterCategory('All');
                    },
                    child: CategoryButton(label: 'All'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Mountain';
                      });
                      filterCategory('Mountain');
                    },
                    child: CategoryButton(label: 'Mountain'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Sea';
                      });
                      filterCategory('Sea');
                    },
                    child: CategoryButton(label: 'Sea'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'Desert';
                      });
                      filterCategory('Desert');
                    },
                    child: CategoryButton(label: 'Desert'),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'cites';
                      });
                      filterCategory('cites');
                    },
                    child: CategoryButton(label: 'cites'),
                  ),
                ],
              ),
            ),



            // Explore Destination Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Explore Destination", style: TextStyle(fontSize: 30)),
                  Row(
                    children: [
                      Text("All  "),
                      Text("Popular  "),
                      Text("Recommended  "),
                      Text(
                        "Most Viewed  ",
                        style: TextStyle(color: Colors.yellow.shade800),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            SizedBox(
              height:getResponsiveHeight(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredCities.length,
                itemBuilder: (context, index) {
                  final place = filteredCities[index];
                  return CustomCard(
                    imageUrl: place.imgurl,
                    title: place.title,
                    price: place.price,
                    rating: place.rating,
                    countryName: place.country,
                    onTap: (){
                      _showCardDialog(context, place);
                    },
                  );
                },
              ),
            ),

            // Popular Categories Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Text("Our Services", style: TextStyle(fontSize: 25)),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryIconButton(icon: FontAwesomeIcons.car, label: "Transport"),
                  CategoryIconButton(icon: FontAwesomeIcons.locationDot, label: "Guide"),
                  CategoryIconButton(icon: FontAwesomeIcons.bed, label: "Hotel"),
                  CategoryIconButton(icon: FontAwesomeIcons.calendarCheck, label: "Event"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.orangeAccent,
        height: screenHeight * 0.1 > 75 ? 75 : screenHeight * 0.1,
        animationCurve: Curves.easeInOut,
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.shopping_cart, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            selectedCategory = 'All';
            filteredCities = place_list;
            _controller.clear();

          });

          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.ro,
                  (route) => false,
            );
          }

          if (index == 1) {
            Navigator.of(context).pushNamed(
              CardScreen.ro,
              arguments: cartItems,
            );
          }

          if (index == 2) {
            _showProfilePopup(context);
          }
        },
      ),
    );
  }

  void _showProfilePopup(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "No Email";
    final photoUrl = user?.photoURL;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: photoUrl != null
                    ? NetworkImage(photoUrl)
                    : AssetImage('assets/profile.jpg') as ImageProvider,
              ),
              SizedBox(height: 10),
              Text(email, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _auth.signOut();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    GetstartScreen.ro,
                        (route) => false,
                  );
                },
                child: Text("LogOut", style: TextStyle(color: Colors.purple)),
              )
            ],
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(-7, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(icon, size: 30, color: Colors.blueGrey),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}

class CategoryIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryIconButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularIconButton(onTap: () {}, icon: icon),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
