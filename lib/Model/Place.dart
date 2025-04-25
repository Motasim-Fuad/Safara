class Place{
  String title;
  String imgurl;
  String country;
  double rating;
  String price;
  String category;
  Place({
    required this.title,
    required this.imgurl,
    required this.country,
    required this.rating,
    required this.price,
    required this.category,
  });

}

final List<Place> place_list = [
  Place(title: "Cox's Bazaar", imgurl: "assets/place_img/coxs_bazaar.jpg", country: "Bangladesh", rating: 4.6, price: "200 usd", category: "Sea"),
  Place(title: "Maldives", imgurl: "assets/place_img/maldip.jpeg", country: "Maldives", rating: 4.8, price: "3000 usd", category: "Sea"),
  Place(title: "Pyramid", imgurl: "assets/place_img/egypt.jpg", country: "Egypt", rating: 4.9, price: "5000 usd", category: "Desert"),
  Place(title: "Bali", imgurl: "assets/place_img/bali.jpg", country: "Indonesia", rating: 5, price: "3500 usd", category: "cites"),
  Place(title: "Barcelona", imgurl: "assets/place_img/bersolona.jpg", country: "Spain", rating: 4.3, price: "4300 usd", category: "cites"),
  Place(title: "Lmja Tse", imgurl: "assets/place_img/lmja_Tse.jpg", country: "China-Nepal", rating: 4.3, price: "2300 usd", category: "Mountain"),
];
