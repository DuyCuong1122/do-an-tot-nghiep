import 'package:compare_car/user/detailCar/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailCarPage extends GetView<DetailCarController> {
  const DetailCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Car'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.network(
                controller.state.thumbnail.value,
                fit: BoxFit.cover,
                width: 600, // Hoặc có thể bỏ width và giữ cho nó là null
                // height: null,
                errorBuilder: (context, error, stackTrace) {
                  return Text('Failed to load image');
                },
              ),
              DataTable(
                columns: [
                  DataColumn(label: Text('Spec')),
                  DataColumn(label: Text('Value')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Model')),
                    DataCell(Text(controller.state.nameCar.value)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Release')),
                    DataCell(Text(controller.state.release.value)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('price')),
                    DataCell(
                      Text(controller.state.price.value.toString()),
                    )
                  ]),
                  DataRow(
                    cells: [
                      DataCell(Text('description')),
                      DataCell(
                        Container(
                          // Độ rộng tối đa của Text
                          child: Text(
                            controller.state.description.value,
                            softWrap:
                                true, // Cho phép tự động xuống dòng khi cần
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(cells: [
                    DataCell(Text('showroom')),
                    DataCell(Text(controller.state.showroom.value)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('State Car')),
                    DataCell(Text(controller.state.stateCar.value)),
                  ]),
                ],
              ),
//         DropdownButton<Car>(
//   value: selected,
//   onChanged: (Car newValue) {
//     setState(() {
//       selectedCar = newValue;
//     });
//   },
//   items: listCar.map<DropdownMenuItem<Car>>((Car car) {
//     return DropdownMenuItem<Car>(
//       value: car,
//       child: Text(car.name),
//     );
//   }).toList(),
// )
            ],
          )),
    );
  }
}

// Image.network(
//               controller.state.image.value,
//               scale: 1.0,
//               width: double.infinity,
//               height: 200,
//               errorBuilder: (context, error, stackTrace) {
//                 return Text('Failed to load image');
//               },
//             ),