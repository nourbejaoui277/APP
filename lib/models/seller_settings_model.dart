class SellerSettingsModel {
  final String id;
  final String username;
  final String email;

  SellerSettingsModel(
      {required this.id, required this.username, required this.email});

  factory SellerSettingsModel.fromJson(Map<String, dynamic> json) {
    return SellerSettingsModel(
        id: json['id'].toString(),
        username: json['nom'],
        email: json['contact']);
  }

  Map<String, dynamic> toJson() =>
      {'id': int.parse(id), 'nom': username, 'contact': email};
}
