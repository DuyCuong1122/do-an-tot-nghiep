import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:compare_car/admin_user/user/home_page/controller.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer =
        Debouncer(delay: const Duration(milliseconds: 500));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              StickyHeader(
                header: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: const AlignmentDirectional(-1, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: TextFormField(
                            controller: controller.search,
                            onChanged: (query) {
                              debouncer
                                  .call(() => controller.getSuggestions(query));
                            },
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Search car',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              suffixIcon: controller.search.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        controller.search.clear();
                                        controller.getSuggestions('');
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => print("button is pressed"),
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                content: Column(
                  children: [
                    const SizedBox(height: 10),
                    Stack(children: [
                      SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: CarouselSlider(
                          items: [
                            for (var i = 0; i < 4; i++)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://picsum.photos/seed/${i + 568}/600',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                          options: CarouselOptions(
                            initialPage: 1,
                            viewportFraction: 0.5,
                            disableCenter: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.25,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayInterval:
                                const Duration(milliseconds: 4800),
                            autoPlayCurve: Curves.linear,
                            pauseAutoPlayInFiniteScroll: true,
                            onPageChanged: (index, _) => controller
                                .state.carouselCurrentIndex.value = index,
                          ),
                        ),
                      ),
                      Obx(() {
                        return Container(
                          color: Colors.white,
                          height: 150,
                          child: controller.state.suggestions.isEmpty
                              ? const SizedBox(
                                  height: 10,
                                )
                              : ListView.builder(
                                  itemCount:
                                      controller.state.suggestions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(controller
                                          .state.suggestions[index]['nameCar']),
                                    );
                                  },
                                ),
                        );
                      }),
                    ]),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 0,
                              color: Colors.grey,
                              offset: Offset(0.0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 12, 16, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                                child: const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Text(
                                      'Lọc',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    100, // Set a fixed width for the dropdown
                                child: Obx(() {
                                  return DropdownButton<String>(
                                    menuMaxHeight: 150,
                                    value: controller.state.selectedValue.value,
                                    items: controller.state.dropdownmenu
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      controller.setSelected(newValue!);
                                      log(controller.state.selectedValue
                                          .toString());
                                      if (newValue != "All") {
                                        controller.fetchCars();
                                      } else {
                                        controller.fetchAllCars();
                                      }
                                      log(controller.state.cars.toString());
                                    },
                                    isExpanded: true,
                                    // Ensure the dropdown expands to fill the container
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() {
                if (controller.state.cars.length > 0) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                    ),
                    itemCount: controller.state.cars.length,
                    shrinkWrap: true, // Added shrinkWrap
                    physics:
                        const NeverScrollableScrollPhysics(), // Disabled scroll physics
                    itemBuilder: (context, index) {
                      final car = controller.state.cars[index];
                      return InkWell(
                        onTap: () => Get.toNamed("/detail", arguments: car),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Uncomment and fix this line if you want to display the image
                                // Image.network(
                                //   car.thumbnail,
                                //   scale: 1.0,
                                //   width: double.infinity,
                                //   height: 300,
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return const Text('Failed to load image');
                                //   },
                                // ),
                                Text(car.nameCar),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
