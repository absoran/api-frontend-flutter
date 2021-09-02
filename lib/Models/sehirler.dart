// ignore_for_file: unnecessary_getters_setters, unnecessary_this

class Sehirler {
  late int _plaka;

  late String _sehir;

  Sehirler(this._plaka, this._sehir);

  //Sehirler.noparam();

  int get plaka => _plaka;

  String get sehir => _sehir;

  set plaka(int newPlaka) {
    _plaka = newPlaka;
  }

  set sehir(String newSehir) {
    _sehir = newSehir;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["isim"] = _sehir;
    map["plaka"] = _plaka;
    return map;
  }

  Sehirler.fromObject(dynamic o) {
    this._sehir = o["isim"];
    this._plaka = o["plaka"];
  }
}
