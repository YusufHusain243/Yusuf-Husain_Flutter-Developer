class Weather {
  String? id;
  String? propinsi;
  String? kota;
  String? kecamatan;

  Weather({
    this.id,
    this.propinsi,
    this.kota,
    this.kecamatan,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propinsi = json['propinsi'];
    kota = json['kota'];
    kecamatan = json['kecamatan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['propinsi'] = propinsi;
    data['kota'] = kota;
    data['kecamatan'] = kecamatan;
    return data;
  }
}
