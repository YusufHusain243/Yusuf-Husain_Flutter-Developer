import 'package:get/get.dart';

class WeatherProvider extends GetConnect {
  final urlWeather = "https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json";

  Future<Response> getDataWeather() => get(urlWeather);

  Future<Response> getDataWeatherById(int number) =>
      get("https://ibnux.github.io/BMKG-importer/cuaca/$number.json");
}
