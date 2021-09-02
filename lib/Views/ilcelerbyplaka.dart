// ignore_for_file: camel_case_types, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:fluttersehirler/Models/services.dart';
import 'dart:convert';

import 'package:fluttersehirler/Views/sehirlerui.dart';

class ilcelerbyplaka extends StatefulWidget {
  const ilcelerbyplaka({Key? key}) : super(key: key);
  //static late int testint;
  @override
  _ilcelerbyplakaState createState() => _ilcelerbyplakaState();
}

class _ilcelerbyplakaState extends State<ilcelerbyplaka> {
  var ilcelers = <Ilceler>[];
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
    getIlceByPlaka(services.getPlaka());
    return Scaffold(
        appBar: AppBar(
          title: Text(services.getSehir() + " İlçeleri"),
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
            ? const Center(child: Text('No response'))
            : ListView.builder(
                itemCount: ilcelers.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                        title: ListTile(title: Text(ilcelers[index].ilce)),
                        subtitle: Text("ID : " +
                            ilcelers[index].id.toString() +
                            ' ' +
                            "Plaka : " +
                            ilcelers[index].plaka.toString()),
                        selected: true,
                        onTap: () {}),
                  );
                },
              ));
  }
}
