class UserModel {
  int? id;
  String? nom;
  String? prenom;
  String? username;
  String? password;
  String? email;

  UserModel({
    this.id,
    this.nom,
    this.prenom,
    this.username,
    this.password,
    this.email,
  });

  Map<String, dynamic> dataMap() {
    var map = <String, dynamic>{
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'username': username,
      'password': password,
      'email': email,
    };
    return map;
  }

  UserModel.fromDBLocal(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }
}
