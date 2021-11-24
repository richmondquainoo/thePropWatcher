class UserProfileModel {
  final int id;
  final String picture;
  final String profileName;
  final String name;
  final String password;
  final String phone;
  final String email;

  UserProfileModel({
    this.id,
    this.picture,
    this.profileName,
    this.name,
    this.password,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "picture": picture,
      "profileName": profileName,
      "name": name,
      "password": password,
      "phone": phone,
      "email": email,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "picture": picture,
      "profileName": profileName,
      "name": name,
      "password": password,
      "phone": phone,
      "email": email,
    };
  }

  @override
  String toString() {
    return 'UserProfileModel{id: $id, picture: $picture, profileName: $profileName, name: $name, password: $password, phone: $phone, email: $email}';
  }
}
