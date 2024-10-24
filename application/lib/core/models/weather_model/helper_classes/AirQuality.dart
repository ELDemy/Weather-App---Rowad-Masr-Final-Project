class AirQuality {
  AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usepaindex,
    this.gbdefraindex,
  });

  AirQuality.fromJson(dynamic json) {
    co = json['co'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm25 = json['pm2_5'];
    pm10 = json['pm10'];
    usepaindex = json['us-epa-index'];
    gbdefraindex = json['gb-defra-index'];
  }
  num? co;
  num? no2;
  num? o3;
  num? so2;
  num? pm25;
  num? pm10;
  num? usepaindex;
  num? gbdefraindex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['co'] = co;
    map['no2'] = no2;
    map['o3'] = o3;
    map['so2'] = so2;
    map['pm2_5'] = pm25;
    map['pm10'] = pm10;
    map['us-epa-index'] = usepaindex;
    map['gb-defra-index'] = gbdefraindex;
    return map;
  }
}
