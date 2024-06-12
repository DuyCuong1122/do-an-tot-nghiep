class Car {
  String id;
  String nameCar;
  String release;

  Car({required this.id, required this.nameCar, required this.release});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'],
      nameCar: json['nameCar'],
      release: json['release'],
    );
  }

  void printAll() {
    print('id: $id, nameCar: $nameCar, release: $release');
  }
}
