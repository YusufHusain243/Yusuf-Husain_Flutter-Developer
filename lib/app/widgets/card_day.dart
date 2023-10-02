import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:get/get.dart';

class CardDay extends GetView<HomeController> {
  CardDay({
    super.key,
    this.tempC,
    this.jamCuaca,
    this.cuaca,
    this.indexCard,
  });

  String? tempC;
  String? jamCuaca;
  String? cuaca;
  int? indexCard;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: secondaryDark,
              width: 2.0,
            ),
          ),
          color: indexCard == controller.indexSelectedCard.value
              ? Colors.white
              : primaryDark,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "$tempC°C",
                  style: TextStyle(
                    fontSize: 18,
                    color: indexCard == controller.indexSelectedCard.value
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                Image.asset(
                  cuaca!.isEmpty ? 'assets/img/1.png' : 'assets/img/2.png',
                  width: 60,
                ),
                Text(
                  jamCuaca!.substring(11, 16),
                  style: TextStyle(
                    fontSize: 18,
                    color: indexCard == controller.indexSelectedCard.value
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
