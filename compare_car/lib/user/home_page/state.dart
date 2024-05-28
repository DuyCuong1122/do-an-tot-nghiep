import 'package:get/get.dart';

import '../../common/entities/entities.dart';

class HomeState {
  RxInt carouselCurrentIndex = 0.obs;
  List<String> dropdownmenu = [
    "All",
    "2024",
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007",
    "2006",
    "2005"
  ];
  RxString selectedValue = "All".obs;
  RxInt choiceChipIndex = 0.obs;
  final List<String> carTypes = ['All', 'Sedan', 'SUV'];
  RxString selectedCarType = 'All'.obs;
  var cars = <Car>[].obs;
  var suggestions = <dynamic>[].obs;
}
