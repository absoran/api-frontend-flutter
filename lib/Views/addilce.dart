// ignore_for_file: unused_import, avoid_web_libraries_in_flutter, non_constant_identifier_names, no_logic_in_create_state

import 'dart:convert';
import 'dart:async';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:fluttersehirler/Models/services.dart';
import 'package:fluttersehirler/Views/ilcelerbyplaka.dart';
import 'package:fluttersehirler/Views/ilcelerui.dart';

class AddIlce extends StatefulWidget {
  final Ilceler ilce;
  const AddIlce(this.ilce, {Key? key}) : super(key: key);

  @override
  _AddIlceState createState() => _AddIlceState(ilce);
}

class _AddIlceState extends State<AddIlce> {
  Ilceler ilce;
  _AddIlceState(this.ilce);
  var Ilceadicontroller = TextEditingController();
  var Ilceplakacontroller = TextEditingController();
  var IlceIDcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Ilceadicontroller.text = ilce.ilce;
    Ilceplakacontroller.text = ilce.plaka.toString();
    IlceIDcontroller.text = ilce.id.toString();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text('İlçe Ekle / Sil'),
          backgroundColor: Colors.green,
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
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
      child: ListView(
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            controller: Ilceadicontroller,
            onChanged: (value) => updateselectedilce(),
            decoration: InputDecoration(
                labelText: 'İlçe Adı',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: Ilceplakacontroller,
              onChanged: (value) => updateselectedplaka(),
              decoration: InputDecoration(
                  labelText: 'Plaka',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: IlceIDcontroller,
              onChanged: (value) => updateselectedID(),
              decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  saveIlce();
                },
                child: const Text('İlçe Ekle'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    fixedSize: const Size(200, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(8.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    updateIlce(ilce);
                    //Navigator.pop(context);
                  },
                  child: const Text('İlçe Güncelle'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      fixedSize: const Size(200, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(8.0))),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  deleteIlce(ilce.id);
                },
                child: const Text('İlçe Sil'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: const Size(200, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(8.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('İptal'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize: const Size(200, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(8.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  void saveIlce() async {
    var saveResponse = await services.postIlce(ilce);
    saveResponse == true
        ? Navigator.pop(context, true)
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hata')));
  }

  void deleteIlce(int ID) async {
    var deleteresponse = await services.deleteIlce(ID);
    deleteresponse == true
        ? ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Kayıt Silindi')))
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hata')));
  }

  void updateIlce(Ilceler ilcem) async {
    var updateresponse = await services.updateIlce(ilcem);
    updateresponse == true
        ? Navigator.pop(context, true)
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hata')));
  }

  void updateselectedilce() {
    ilce.ilce = Ilceadicontroller.text;
  }

  void updateselectedplaka() {
    ilce.plaka = int.parse(Ilceplakacontroller.text);
  }

  void updateselectedID() {
    ilce.id = int.parse(IlceIDcontroller.text);
  }
}
