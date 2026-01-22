class Productdetails {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;

  Productdetails({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  factory Productdetails.fromJson(Map<String, dynamic> json) {
    return Productdetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
    );
  }
}
