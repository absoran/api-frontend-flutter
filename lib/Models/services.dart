// ignore_for_file: non_constant_identifier_names, unused_import, camel_case_types, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:math';

class services {
  static String baseUrl = 'https://localhost:44385';
  static String SehirUrl = 'https://localhost:44385/api/GetSehir';
  static String IlceUrl = 'https://localhost:44385/api/GetIlceler';
  static String SehirByPlakaUrl =
      'https://localhost:44385/api/GetSehirByPlaka?plaka=';
  static String IlceByPlaka =
      'https://localhost:44385/api/GetIlcelerByPlaka?plaka=';
  static String addSehirUrl = 'https://localhost:44385/api/AddSehir';
  static String addIlceUrl = 'https://localhost:44385/api/AddIlce';
  static String deleteSehirUrl =
      'https://localhost:44385/api/DeleteSehir?plaka=';

  static String updateSehirUrl = 'https://localhost:44385/api/UpdateSehir';
  static String deleteIlceUrl = 'https://localhost:44385/api/DeleteIlce?id=';
  static String updateIlceUrl = 'https://localhost:44385/api/ADOUpdateIlce';
  static String GetIlceByIDUrl = 'https://localhost:44385/api/GetIlceById?ID=';
  static late int _plaka;
  static late String _sehir;
  static List<Ilceler> ilcelerlist = <Ilceler>[];
  /*
  
  
  
   */
  static Future fetchSehir() async {
    return await http.get(Uri.parse(SehirUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
  }

  static setSehir(String newSehir) {
    _sehir = newSehir;
  }

  static String getSehir() {
    return _sehir;
  }

  static setPlaka(int newPlaka) {
    _plaka = newPlaka;
  }

  static int getPlaka() {
    return _plaka;
  }

  static Map<String, String> header = {
    "Accept": "application/json",
    'Content-type': 'application/json',
    "Access-Control_Allow_Origin": "*"
  };

  static Future fetchSehirler() async {
    var response = await http.get(Uri.parse(SehirUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    Iterable list = json.decode(response.body);
    List<Ilceler> ilcelist = <Ilceler>[];
    ilcelist = list.map((model) => Ilceler.fromObject(model)).toList();
    return ilcelist;
  }

  static Future fetchIlce() async {
    final response2 = http.get(Uri.parse(IlceUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    return response2;
  }

  static Future fetchSehirByplaka(int plaka) async {
    String url = SehirByPlakaUrl + plaka.toString();
    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    //print(response.body);
    return response;
  }
/*
  static Future<Sehirler> fetchSehirByPlaka(int plaka) async {
    String url = SehirByPlakaUrl + plaka.toString();
    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.toString());
      print(map);
    }
  }*/

  static Future fetchIlcebyID(int ID) async {
    String url = GetIlceByIDUrl + ID.toString();
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    return response;
  }

  static Future fetchIlceByplaka(int plaka) async {
    String url = IlceByPlaka + plaka.toString();
    final respons = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    return respons;
  }

  static Future<bool> postSehir(Sehirler sehir) async {
    var sehirx = sehir.toMap();
    var sehirbody = json.encode(sehirx);
    var res = await http.post(Uri.parse(addSehirUrl),
        headers: header, body: sehirbody);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> postIlce(Ilceler ilce) async {
    var ilcex = ilce.toMap();
    var ilcebody = json.encode(ilcex);
    var res =
        await http.post(Uri.parse(addIlceUrl), headers: header, body: ilcebody);
    return Future.value(res.statusCode == 200 ? true : false);
  }

/*
  static Future<bool> postIlce(Ilceler ilce) async {
    var ilcex = ilce.toMap();
    var ilcebody = json.encode(ilcex);
    var res = await http.post(Uri.parse(addSehirUrl),
        headers: header, body: ilcebody);
    return Future.value(res.statusCode == 200 ? true : false);
  }
*/
  static Future<bool> deleteSehir(int plaka) async {
    String url = deleteSehirUrl + plaka.toString();
    var res = await http.delete(Uri.parse(url), headers: header);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> deleteIlce(int ID) async {
    String url = deleteIlceUrl + ID.toString();
    var res = await http.delete(Uri.parse(url), headers: header);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> updateSehir(Sehirler sehir) async {
    var sehirx = sehir.toMap();
    var sehirbody = json.encode(sehirx);
    var res = await http.put(Uri.parse(updateSehirUrl),
        headers: header, body: sehirbody);
    return Future.value(res.statusCode == 200 ? true : false);
    //return Future.value(res.statusCode);
  }

  static Future<bool> updateIlce(Ilceler ilce) async {
    var ilcex = ilce.toMap();
    var ilcebody = json.encode(ilcex);
    var res = await http.put(Uri.parse(updateIlceUrl),
        headers: header, body: ilcebody);
    return Future.value(res.statusCode == 200 ? true : false);
  }
}

/*
class ServiceDataProvider {
  final _baseUrl = 'https://localhost:44385/api';
  final http.Client httpClient;
  var sehirs = <Sehirler>[];
  ServiceDataProvider({required this.httpClient}) : assert(httpClient != null);
  Future<services> createService(Sehirler service) async {
    List<Sehirler> sehirlist = <Sehirler>[];
    final response = await httpClient.post(
      Uri.http('https://localhost:44385', '/api/Sehirler/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
      body: jsonEncode(
          <String, dynamic>{"isim": service.sehir, "plaka": service.plaka}),
    );

    if (response.statusCode == 200) {
      var testvar = jsonDecode(response.body);
      print('test, ${testvar.plaka}');
      return testvar;
      //return services.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course.');
    }
  }
}*/
