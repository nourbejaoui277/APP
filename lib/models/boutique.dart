class Boutique {
  final String nom;
  final String userId;
  final String description;
  final String address;
  final String contact;

  Boutique({
    required this.nom,
    required this.userId,
    required this.description,
    required this.address,
    required this.contact,
  });

  factory Boutique.fromJson(Map<String, dynamic> json) {
    return Boutique(
      nom: json['nom'],
      userId: json['userId'],
      description: json['description'],
      address: json['address'],
      contact: json['contact'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'userId': userId,
        'description': description,
        'address': address,
        'contact': contact,
      };
}
