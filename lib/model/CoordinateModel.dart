class CoordinateModel {
  double latitude;
  double longitude;
  double accuracy;

  CoordinateModel({
    this.latitude,
    this.longitude,
    this.accuracy,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
    };
  }

  @override
  String toString() {
    return 'CoordinateModel{latitude: $latitude, longitude: $longitude, accuracy: $accuracy}';
  }
}
