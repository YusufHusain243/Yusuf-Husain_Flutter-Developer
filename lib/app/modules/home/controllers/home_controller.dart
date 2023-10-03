import 'dart:async';

import 'package:flutter_application_1/app/data/models/weather_day_model.dart';
import 'package:flutter_application_1/app/data/models/weather_model.dart';
import 'package:flutter_application_1/app/providers/weather_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<Map> {
  var isSearch = false.obs;
  var isLoading = true.obs;
  var weatherDay = WeatherDay().obs;
  var indexSelectedCard = 0.obs;
  var kota = ''.obs;
  var kecamatan = ''.obs;

  RxList<Weather> weather = RxList<Weather>();
  RxList<WeatherDay> listWeatherDay = RxList<WeatherDay>();

  List<String> data = ['a', 'b', 'c'];

  @override
  void onInit() {
    super.onInit();
    getById(501397);
    get();
  }

  void search(bool isSearch) {
    this.isSearch.value = isSearch;
    update();
  }

  void loading(bool isLoading) {
    this.isLoading.value = isLoading;
    update();
  }

  void changeWeatherDay(int index) {
    weatherDay.value = listWeatherDay[index];
    indexSelectedCard.value = index;
    update();
  }

  void setKecamatan(String kota, String kecamatan) {
    this.kota.value = kota;
    this.kecamatan.value = kecamatan;
    update();
  }

  Future searchData(String pattern) async {
    List<String> result =
        data.where((element) => element.contains(pattern)).toList();
    return result;
  }

  void get() {
    try {
      loading(true);
      WeatherProvider().getDataWeather().then((response) {
        if (response.statusCode == 200) {
          List jsonResponse = response.body;
          weather.value =
              jsonResponse.map((weather) => Weather.fromJson(weather)).toList();
          setKecamatan(weather[0].kota!, weather[0].kecamatan!);
          loading(false);
        } else {
          return null;
        }
      });
    } catch (e) {
      return;
    }
  }

  void getById(int id) async {
    try {
      loading(true);
      await WeatherProvider().getDataWeatherById(id).then((response) {
        if (response.statusCode == 200) {
          List jsonResponse = response.body;
          listWeatherDay.value = jsonResponse
              .map((weatherDay) => WeatherDay.fromJson(weatherDay))
              .toList();
          changeWeatherDay(0);
          loading(false);
        } else {
          return null;
        }
      });
    } catch (e) {
      return;
    }
  }
}
