import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/weather_model.dart';
import 'package:flutter_application_1/app/widgets/list_day.dart';
import 'package:flutter_application_1/theme.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 30,
          ),
          decoration: primaryDarkGradient,
          child: SafeArea(
            child: Obx(
              () {
                if (controller.isLoading.isFalse) {
                  return Column(
                    children: [
                      if (controller.isSearch.isFalse) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.kota.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.search(true);
                              },
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Padding(
                          padding: EdgeInsets.all(defaultMagrin),
                          child: Autocomplete<Weather>(
                            optionsBuilder: (
                              TextEditingValue textEditingValue,
                            ) {
                              return controller.weather
                                  .where(
                                    (Weather weather) => weather.kecamatan!
                                        .toLowerCase()
                                        .startsWith(
                                          textEditingValue.text.toLowerCase(),
                                        ),
                                  )
                                  .toList();
                            },
                            displayStringForOption: (Weather option) =>
                                option.kecamatan!,
                            fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              return TextField(
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Masukkan Kecamatan',
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.search(false);
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            onSelected: (Weather selection) {
                              controller.getById(int.parse(selection.id!));
                              controller.isSearch(false);
                              controller.setKecamatan(
                                selection.kota!,
                                selection.kecamatan!,
                              );
                            },
                            optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<Weather> onSelected,
                              Iterable<Weather> options,
                            ) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(10.0),
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Weather option =
                                            options.elementAt(index);
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                          },
                                          child: ListTile(
                                            title: Text(
                                              option.kecamatan!,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.isSearch.isFalse) ...[
                        Text(
                          controller.kecamatan.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                      const SizedBox(height: 30),
                      Image.asset(
                        controller.weatherDay.value.cuaca!.isEmpty
                            ? 'assets/img/1.png'
                            : 'assets/img/2.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "${controller.weatherDay.value.tempC}°C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 60,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.weatherDay.value.jamCuaca!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.weatherDay.value.cuaca!.isEmpty
                            ? "Cerah Berawan"
                            : "Cerah",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const ListDay(),
                    ],
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
