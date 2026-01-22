class Promotion {
  final String id;
  final String title;
  final String description;
  final num discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final String productId;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.productId,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      discountPercentage: json['discountPercentage'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'discountPercentage': discountPercentage,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'productId': productId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        'id': id,
        'title': title,
        'description': description,
        'discountPercentage': discountPercentage,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'productId': productId,
      };
}
