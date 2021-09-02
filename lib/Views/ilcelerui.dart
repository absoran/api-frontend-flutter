// ignore_for_file: camel_case_types, avoid_print, unused_import

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:fluttersehirler/Models/services.dart';

class ilcelerui extends StatefulWidget {
  const ilcelerui({Key? key}) : super(key: key);

  @override
  _ilceleruiState createState() => _ilceleruiState();
}

class _ilceleruiState extends State<ilcelerui> {
  var ilcelers = <Ilceler>[];
  getIlce() {
    services.fetchIlce().then((response) {
      Iterable list = json.decode(response.body);
      List<Ilceler> ilcelist = <Ilceler>[];
      ilcelist = list.map((model) => Ilceler.fromObject(model)).toList();
      setState(() {
        ilcelers = ilcelist;
      });
    });
  }

  getIlceByPlaka(int plaka) {
    services.fetchIlceByplaka(plaka).then((response) {
      Iterable list = json.decode(response.body);
      List<Ilceler> ilcelist = <Ilceler>[];
      ilcelist = list.map((model) => Ilceler.fromObject(model)).toList();
      setState(() {
        ilcelers = ilcelist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getIlce();
    return Scaffold(
        appBar: AppBar(
          title: const Text('İlçeler'),
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
        body: ilcelers.isEmpty
            ? const Center(child: Text('Yükleniyor'))
            : ListView.builder(
                itemCount: ilcelers.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                        title: ListTile(
                            title: Center(child: Text(ilcelers[index].ilce))),
                        subtitle: Center(
                            child: Text((ilcelers[index].plaka).toString())),
                        selected: true,
                        onTap: () {}),
                  );
                },
              ));
  }
}
