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

class AddSehir extends StatefulWidget {
  final Sehirler sehir;
  const AddSehir(this.sehir, {Key? key}) : super(key: key);

  @override
  _AddSehirState createState() => _AddSehirState(sehir);
}

class _AddSehirState extends State<AddSehir> {
  Sehirler sehir;
  _AddSehirState(this.sehir);
  var Sehiradicontroller = TextEditingController();
  var Sehirplakacontroller = TextEditingController();
  //var textStyle = TextStyle();
  @override
  Widget build(BuildContext context) {
    Sehiradicontroller.text = sehir.sehir;
    Sehirplakacontroller.text = sehir.plaka.toString();
    //textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text('Şehir Ekle / Sil / Güncelle'),
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
            controller: Sehiradicontroller,
            onChanged: (value) => updateselectedsehir(),
            decoration: InputDecoration(
                labelText: 'Şehir Adı',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: Sehirplakacontroller,
              onChanged: (value) => updateselectedplaka(),
              decoration: InputDecoration(
                  labelText: 'Plaka',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  saveSehir();
                },
                child: const Text('Şehir Kaydet'),
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
                    Navigator.pop(context);
                  },
                  child: const Text('İptal'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      fixedSize: const Size(200, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(8.0))),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  deleteSehir(sehir.plaka);
                },
                child: const Text('Şehir Sil'),
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
                  updateSehir(sehir);
                },
                child: const Text('Şehir Güncelle'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
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

  void saveSehir() async {
    var saveResponse = await services.postSehir(sehir);
    saveResponse == true
        ? Navigator.pop(context, true)
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hata')));
  }

  void deleteSehir(int plaka) async {
    var deleteresponse = await services.deleteSehir(plaka);
    deleteresponse == true
        ? Navigator.pop(context, true)
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Silinmek istenen şehir yok veya bağlantı hatası')));
  }

  void updateSehir(Sehirler sehir) async {
    var updateresponse = await services.updateSehir(sehir);
    updateresponse == true
        ? Navigator.pop(context, true)
        : ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Hata')));
  }

  void updateselectedsehir() {
    sehir.sehir = Sehiradicontroller.text;
  }

  void updateselectedplaka() {
    sehir.plaka = int.parse(Sehirplakacontroller.text);
  }
}
