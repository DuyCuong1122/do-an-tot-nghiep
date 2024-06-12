import 'package:compare_car/admin_user/admin/addCar/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCarPage extends GetView<AddCarController> {
  const AddCarPage({super.key});

  AppBar buildAppBar() {
    return AppBar(
        title: const Text(
      "Add Car",
      style: TextStyle(
          color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w600),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.nameCarController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name Car',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.releaseController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Release',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.showroomController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Showroom',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.stateCarController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'State Car',
                  hintText: 'in production, out of production, etc.'),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Thumbnail'),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(() {
                    return controller.state.file.value != null
                        ? Image.file(
                            controller.state.file.value!,
                            height: imageSize,
                            width: imageSize,
                          )
                        : const SizedBox(
                            width: 20,
                          );
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickFile();
                    },
                    child: const Text('Choose image'),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.createCar();
              },
              child: const Text('Add Car'),
            ),
          ),
        ],
      ),
    );
  }
}
