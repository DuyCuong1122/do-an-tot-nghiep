import 'package:compare_car/user/compareCar/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComparePage extends GetView<CompareController> {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> createColumns(String category) {
      return [
        DataColumn(
            label: Center(
                child: Text(controller.state.carsWithSpecs1[0].car.nameCar))),
        DataColumn(label: Center(child: Text(category))),
        DataColumn(
            label: Center(
                child: Text(controller.state.carsWithSpecs2[0].car.nameCar)))
      ];
    }

    DataRow createRows(String specName) {
      final spec1 = controller.state.carsWithSpecs1[0].specs
          .firstWhereOrNull((element) => element.specName == specName);
      final spec2 = controller.state.carsWithSpecs2[0].specs
          .firstWhereOrNull((element) => element.specName == specName);
      return DataRow(cells: [
        DataCell(Center(
            child: Text(spec1 != null && spec1.value != "null"
                ? (spec1.value.toString() == "Available"
                    ? "V"
                    : spec1.value.toString())
                : "X"))),
        DataCell(Center(child: Text(specName))),
        DataCell(Center(
            child: Text(spec2 != null && spec2.value != "null"
                ? (spec2.value.toString() == "Available"
                    ? "V"
                    : spec2.value.toString())
                : "X"))),
      ]);
    }

    DataTable createTable(String category, List<DataRow> spec) {
      return DataTable(
        columns: createColumns(category),
        rows: spec,
        border:
            TableBorder.all(width: 1, borderRadius: BorderRadius.circular(8)),
      );
    }

    final maxSize = MediaQuery.of(context).size.width;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          "https://platform.cstatic-images.com/in/v2/stock_photos/9e6d1b36-6335-47b2-bc87-7406bfce5c54/f11545c5-23c9-4b12-9552-de32d2a3b8bf.png",
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
                            "https://www.motortrend.com/uploads/2022/04/2023-BMW-M8-Competition-42.jpg",
                            width: maxSize / 2.0,
                            fit: BoxFit.contain),
                      )
                    ],
                  ),
                  Obx(() {
                    if (controller.state.carsWithSpecs1.isNotEmpty &&
                        controller.state.carsWithSpecs2.isNotEmpty) {
                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller.state.commonCategories
                                .expand((category) {
                              final commonSpecNames = controller
                                  .state.car1SpecsByCategory[category]!
                                  .intersection(controller
                                      .state.car2SpecsByCategory[category]!);
                              return [
                                SizedBox(
                                  width: maxSize - 30,
                                  child: createTable(
                                      category,
                                      commonSpecNames
                                          .map((specName) =>
                                              createRows(specName))
                                          .toList()),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ];
                            }).toList(),
                          ));
                    } else {
                      return const Text(
                        "No data available",
                        style: TextStyle(fontSize: 30),
                      );
                    }
                  }),
                ]),
          ),
        ),
      ),
    ));
  }
}
