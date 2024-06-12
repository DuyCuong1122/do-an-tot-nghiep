// import 'dart:developer';

// import 'entities.dart';

// class Comparison {
//   Car car1;
//   List<Spec> specs1;

//   Car car2;
//   List<Spec> specs2;

//   Comparison({
//     required this.car1,
//     required this.specs1,
//     required this.car2,
//     required this.specs2,
//   });

//   factory Comparison.fromJson(Map<String, dynamic> json) {
//     final car1Json = json['car1'];
//     var specs1Json = json['specs1'] as List<dynamic>;
//     final car2Json = json['car2'];
//     var specs2Json = json['specs2'] as List<dynamic>;
//     // log(specs1Json.toString());
//     // log(specs2Json.runtimeType.toString());
//     log(car1Json.toString());
//     final car1 = Car.fromJson(car1Json);
//     final car2 = Car.fromJson(car2Json);

//     List<Spec> spec1List = specs1Json.map((i) => Spec.fromJson(i)).toList();
//     List<Spec> spec2List = specs2Json.map((i) => Spec.fromJson(i)).toList();
//     // List<Spec> specs1 = specs1List.map((data) => Spec.fromJson(data)).toList();
//     // List<Spec> specs2 = specs2List.map((data) => Spec.fromJson(data)).toList();

//     return Comparison(
//       car1: car1,
//       specs1: spec1List,
//       car2: car2,
//       specs2: spec2List,
//     );
//   }
// }

import 'package:compare_car/common/entities/spec.dart';

import 'car.dart';

class CarWithSpecs {
  Car car;
  List<Spec> specs;

  CarWithSpecs({required this.car, required this.specs});

  factory CarWithSpecs.fromJson(
      Map<String, dynamic> json, String carKey, String specsKey) {
    return CarWithSpecs(
      car: Car.fromJson(json[carKey]),
      specs:
          (json[specsKey] as List).map((spec) => Spec.fromJson(spec)).toList(),
    );
  }
}
