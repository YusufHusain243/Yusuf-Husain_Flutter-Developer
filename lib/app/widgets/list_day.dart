import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/widgets/card_day.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/utils/substring.dart';

import '../modules/home/controllers/home_controller.dart';

class ListDay extends GetView<HomeController> {
  const ListDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(defaultMagrin),
        padding: EdgeInsets.all(defaultMagrin),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: primaryDark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultMagrin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tanggal',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Obx(
                    () => Text(
                      substring(controller.weatherDay.value.jamCuaca!, 0, 10),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listWeatherDay.length,
                  itemBuilder: (_, i) => InkWell(
                    onTap: () {
                      controller.changeWeatherDay(i);
                    },
                    child: CardDay(
                      jamCuaca: controller.listWeatherDay[i].jamCuaca,
                      cuaca: controller.listWeatherDay[i].cuaca,
                      tempC: controller.listWeatherDay[i].tempC,
                      indexCard: i,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
