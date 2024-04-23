class Car {
  final String nameCar;
  final String release;
  final double price;
  final String description;
  final String thumbnail;
  final String showroom;
  final String stateCar;

  Car({
    required this.nameCar,
    required this.release,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.showroom,
    required this.stateCar,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      nameCar: json['nameCar'] != null ? json['nameCar'] as String : '',
      release: json['release'] != null ? json['release'] as String : 'hehe',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      description:
          json['description'] != null ? json['description'] as String : '',
      thumbnail: json['thumbnail'] != null ? json['thumbnail'] as String : '',
      showroom: json['showroom'] != null ? json['showroom'] as String : '',
      stateCar: json['stateCar'] != null ? json['stateCar'] as String : '',
    );
  }

  void printAll() {
    print('Name: ' + nameCar);
    print('Image: ' + thumbnail);
  }
}
