// ignore_for_file: unused_import, avoid_web_libraries_in_flutter, camel_case_types

import 'dart:convert';
import 'dart:async';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:fluttersehirler/Models/services.dart';
import 'package:fluttersehirler/Views/addsehir.dart';
import 'package:fluttersehirler/Views/ilcelerbyplaka.dart';
import 'package:fluttersehirler/Views/ilcelerui.dart';

class sehirlerui extends StatefulWidget {
  const sehirlerui({Key? key}) : super(key: key);

  @override
  _sehirleruiState createState() => _sehirleruiState();
}

class _sehirleruiState extends State<sehirlerui> {
  var sehirs = <Sehirler>[];
  var ilcelers = <Ilceler>[];
  static late int selectedindex;
  static late String selectedSehir;
  /*






  */
  getSehir() {
    services.fetchSehir().then((response) {
      Iterable list = json.decode(response.body);
      List<Sehirler> sehirlist = <Sehirler>[];
      sehirlist = list.map((model) => Sehirler.fromObject(model)).toList();
      setState(() {
        sehirs = sehirlist;
      });
    });
  }

  void navigateobj(Sehirler sehir) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSehir(sehir)),
    );
  }

  @override
  Widget build(BuildContext context) {
    getSehir();
    return Scaffold(
        floatingActionButton: _floatinbuttonbuild(),
        appBar: AppBar(
          title: const Text('Şehirler'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.book),
              tooltip: 'icon tooltip',
              onPressed: () {
                //ToDo
              },
            )
          ],
        ),
        body: sehirs.isEmpty
            ? const Center(child: Text('Yükleniyor'))
            : ListView.builder(
                itemCount: sehirs.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      title: ListTile(
                        title: Center(child: Text(sehirs[index].sehir)),
                        subtitle: Center(
                            child: Text((sehirs[index].plaka).toString())),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      ),
                      onTap: () {
                        selectedindex = sehirs[index].plaka;
                        selectedSehir = sehirs[index].sehir;
                        services.setPlaka(selectedindex);
                        services.setSehir(selectedSehir);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ilcelerbyplaka()));
                      },
                    ),
                  );
                },
              ));
  }

  Widget _floatinbuttonbuild() {
    return FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: () {
          navigateobj(Sehirler(0, ''));
        });
  }
}
