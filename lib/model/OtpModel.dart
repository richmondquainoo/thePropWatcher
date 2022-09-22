class OTPModel {
  int id;
  String name;
  String email;
  String phone;
  String password;
  String country;
  int pin;

  OTPModel({
    this.id,
    this.name,
    this.email,
    this.pin,
    this.phone,
    this.password,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'email': email,
      'pin': pin,
      'phone': phone,
      'password': password,
      'country': country,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'email': email,
      'pin': pin,
      'phone': phone,
      'password': password,
      'country': country,
    };
  }

  @override
  String toString() {
    return 'OTPModel{id: $id, name: $name, email: $email, phone: $phone, password: $password, country: $country, pin: $pin}';
  }
}
