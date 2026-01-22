class Product {
  final String id;
  final String name;
  final String description;
  final num price;
  final int stock;
  final int sectionId;
  final int categoryId;
  final int boutiqueId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.sectionId,
    required this.categoryId,
    required this.boutiqueId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      sectionId: json['sectionId'],
      categoryId: json['categoryId'],
      boutiqueId: json['boutiqueId'],
    );
  }

  Map<String, dynamic> toJson() => {
        //'id': id,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'sectionId': sectionId,
        'categoryId': categoryId,
        'boutiqueId': boutiqueId,
      };
}
