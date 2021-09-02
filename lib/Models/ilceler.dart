// ignore_for_file: unnecessary_getters_setters, unnecessary_this, non_constant_identifier_names

class Ilceler {
  late int _plaka;
  late String _ilce;
  late int _id;
  Ilceler(this._plaka, this._ilce, this._id);

  int get plaka => _plaka;
  String get ilce => _ilce;
  int get id => _id;

  set plaka(int newPlaka) {
    _plaka = newPlaka;
  }

  set ilce(String newIlce) {
    _ilce = newIlce;
  }

  set id(int newID) {
    _id = newID;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = _id;
    map["ilce"] = _ilce;
    map["plaka"] = _plaka;
    return map;
  }

  Ilceler.fromObject(dynamic o) {
    this._id = o["id"];
    this._plaka = o["plaka"];
    this._ilce = o["ilce"];
  }
}
