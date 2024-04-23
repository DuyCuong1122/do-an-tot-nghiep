import 'package:compare_car/user/compareCar/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComparePage extends GetView<CompareController> {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    final maxSize = MediaQuery.of(context).size.width / 2;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Compare Car',
          style: TextStyle(
              color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: controller.car1Controller,
                  decoration:
                      const InputDecoration(labelText: 'Enter car 1 name'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.car2Controller,
                  decoration:
                      const InputDecoration(labelText: 'Enter car 2 name'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.getInfo2Cars,
                  child: const Text('Compare'),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.state.cars.isNotEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            controller.state.cars[0].thumbnail,
                            width: maxSize / 2.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.network(
                              controller.state.cars[1].thumbnail,
                              width: maxSize / 2.0,
                              fit: BoxFit.contain),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                Obx(() {
                  if (controller.state.cars.isNotEmpty) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Car 1'),
                            ),
                            DataColumn(
                              label: Text('Car 2'),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                    Text(controller.state.cars[0].nameCar)),
                                DataCell(
                                    Text(controller.state.cars[1].nameCar)),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                    controller.state.cars[0].price.toString())),
                                DataCell(Text(
                                    controller.state.cars[1].price.toString())),
                              ],
                            ),
                          ],
                        ));
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
