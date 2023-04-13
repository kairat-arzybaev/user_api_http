import 'name_model.dart';

class User {
  final String email;
  final String picture;
  final Name name;

  const User({
    required this.email,
    required this.picture,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      picture: json['picture']['medium'],
      name: Name.fromJson(json['name']),
    );
  }
}
