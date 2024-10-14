class Alerts {
  Alerts({
    this.alert,
  });
  List<dynamic>? alert;

  Alerts.fromJson(dynamic json) {
    if (json['alert'] != null) {
      alert = [];
      json['alert'].forEach((v) {
        alert?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (alert != null) {
      map['alert'] = alert?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
