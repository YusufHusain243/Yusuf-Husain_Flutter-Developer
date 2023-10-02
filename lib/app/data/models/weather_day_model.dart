class WeatherDay {
  String? jamCuaca;
  String? cuaca;
  String? tempC;

  WeatherDay({
    this.jamCuaca,
    this.cuaca,
    this.tempC,
  });

  WeatherDay.fromJson(Map<String, dynamic> json) {
    jamCuaca = json['jamCuaca'];
    cuaca = json['cuaca'];
    tempC = json['tempC'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jamCuaca'] = jamCuaca;
    data['cuaca'] = cuaca;
    data['tempC'] = tempC;
    return data;
  }
}
