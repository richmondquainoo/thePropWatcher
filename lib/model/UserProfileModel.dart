class UserProfileModel {
  int id;
  String picture;
  String profileName;
  String name;
  String password;
  String phone;
  String email;
  String country;
  String loggedIn;

  UserProfileModel({
    this.id,
    this.picture,
    this.profileName,
    this.name,
    this.password,
    this.phone,
    this.email,
    this.country,
    this.loggedIn,
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
      "country": country,
      "loggedIn": loggedIn,
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
      "country": country,
      "loggedIn": loggedIn,
    };
  }

  @override
  String toString() {
    return 'UserProfileModel{id: $id, picture: $picture, profileName: $profileName, name: $name, password: $password, phone: $phone, email: $email, country: $country, loggedIn: $loggedIn}';
  }
}
