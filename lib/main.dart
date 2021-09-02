// ignore_for_file: avoid_print

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttersehirler/Models/ilceler.dart';
import 'package:fluttersehirler/Models/sehirler.dart';
import 'package:fluttersehirler/Views/addilce.dart';
import 'package:fluttersehirler/Views/addsehir.dart';
import 'package:fluttersehirler/Views/ilcelerui.dart';
import 'package:fluttersehirler/Views/sehirlerui.dart';
import 'package:fluttersehirler/Models/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'lorem ipsum ';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static const String _appbar = 'Şehirler API ';
  String _isim = '';
  String _plaka = '';
  static int generateNumber() {
    int max = 81;
    int randomNumber = Random().nextInt(max) + 1;
    return randomNumber;
  }

  getRandomSehir() async {
    int rnd = generateNumber();
    services.fetchSehirByplaka(rnd).then((response) {
      var parsed = json.decode(response.body);
      var isim = parsed['isim'];
      var plaka = parsed['plaka'];
      var il = Sehirler(plaka, isim);
      _isim = il.sehir;
      _plaka = il.plaka.toString();
      //print(il.sehir + ' ' + il.plaka.toString());
/*
      setState(() {
        _isim = il.sehir;
        _plaka = il.plaka.toString();
      });*/
      return il;
    });
  }

  @override
  Widget build(BuildContext context) {
    getRandomSehir();
    //Future<Sehirler> sehir = getRandomSehir();
    //print(sehir.plaka.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(_appbar),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'test icon',
            onPressed: () {
              //services.fetchSehirByplaka(34);
              getRandomSehir();
              print(_isim + _plaka);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clicked on test icon')));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 55.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Methods',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Şehirleri getir'),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const sehirlerui()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('İlçeleri getir'),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ilcelerui()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Şehir Ekle / Sil / Güncelle'),
              tileColor: Colors.green,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddSehir(Sehirler(0, ""))));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('İlçe Ekle / Sil / Güncelle'),
              tileColor: Colors.green,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddIlce(Ilceler(0, "", 0))));
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              color: const Color.fromRGBO(255, 165, 0, 0.8),
              alignment: Alignment.center,
              child: const Text(
                "Günün Şanslısı",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: ListTile(
                title: ListTile(
                  title: Center(
                    child: Text(
                      'Adı : ' + _isim,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  subtitle: Center(
                    child: Text('Plakası : ' + _plaka),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}



/*



  ^^^^ random number generate ^^^^
  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);


  Random _random = new Random();
  int randomNumber = _random.nextInt(100);


child: ListTile(
          title: Row(
            children: const [
              Text(
                'rastgele geitr',
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),




body: ListView(
        children: [
          Row(
            children: const [
              Text(
                'toDo',
                style: TextStyle(fontSize: 20),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          ListTile()
        ],
      ),





class Sehirler extends StatelessWidget {
  const Sehirler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const <Widget>[
          Expanded(
              child: Text(
            'GET',
            style: TextStyle(fontSize: 30, color: Colors.blue),
          )),
          Expanded(
              child: Text(
            'POST',
            style: TextStyle(fontSize: 30, color: Colors.green),
          )),
          Expanded(
              child: Text(
            'PUT',
            style: TextStyle(fontSize: 30, color: Colors.orange),
          )),
          Expanded(
              child: Text(
            'DELETE',
            style: TextStyle(fontSize: 30, color: Colors.red),
          ))
        ],
      ),
    );
  }
}
*/


/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'lorem ipsum ';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: sehirlerui(),
    );
  }
}*/
/*
class MyStatelessWidged extends StatelessWidget {
  const MyStatelessWidged({Key? key}) : super(key: key);
  static const String _appbar = 'Şehirler API ';

  getRandomSehir() {
    var sehir = Sehirler;
    int max = 82;
    int randomNumber = Random().nextInt(max) + 1;
    services.fetchSehirByplaka(randomNumber).then((response) {
      sehir = json.decode(response.body);
      return sehir;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(_appbar),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'test icon',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clicked on test icon')));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 55.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Methods',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Şehirleri getir'),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const sehirlerui()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('İlçeleri getir'),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ilcelerui()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Şehir Ekle / Sil / Güncelle'),
              tileColor: Colors.green,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddSehir(Sehirler(0, ""))));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('İlçe Ekle / Sil / Güncelle'),
              tileColor: Colors.green,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddIlce(Ilceler(0, "", 0))));
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Card();
        },
      ),
    );
  }
}
*/