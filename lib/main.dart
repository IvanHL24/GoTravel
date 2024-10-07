import 'dart:convert';

import 'package:app_travels/models/BestSeller.dart';
import 'package:app_travels/models/nacional.dart';
import 'package:app_travels/models/new.dart';
import 'package:app_travels/models/internacional.dart';
import 'package:app_travels/travels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<List<BestSeller>> _listadoBestSellers;
  late Future<List<New>> _listadoNews;
  late Future<List<Internacional>> _listadoInternacionales;
  late Future<List<Nacional>> _listadoNacionales;

  Future<List<BestSeller>> _getBestSellers() async {
    // URL de la API
    final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getHome');

    // Encabezado
    final headers = {
      'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    List<BestSeller> bestsellers = [];


    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var element in jsonData["masvendidos"]){
        bestsellers.add(
          BestSeller(element["nombre"], element["imagen"])
        );
      }

      return bestsellers;

    } else {
      throw Exception("Fallo la conexion");
    }
  }


  Future<List<New>> _getNews() async {
    // URL de la API
    final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getHome');

    // Encabezado
    final headers = {
      'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    List<New> news = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var element in jsonData["novedades"]) {
        news.add(
          New(element["nombre"], element["imagen"])
        );
      }

      return news;
    
    } else {
      throw Exception("Fallo la conexión de novedades");
    }
  }



  
  Future<List<Internacional>> _getInternacionales() async {
    // URL de la API
    final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getInfo');

    // Encabezado
    final headers = {
      'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    List<Internacional> internacionales = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var element in jsonData["internacionales"]) {
        internacionales.add(
          Internacional(element["titulo"], element["ruta"])
        );
      }

      return internacionales;
    } else {
      throw Exception("Fallo la conexión en getInternacionales");
    }
  }


  Future<List<Nacional>> _getNacionales() async {
    // URL de la API
    final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getInfo');

    // Encabezado
    final headers = {
      'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    List<Nacional> nacionales = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var element in jsonData["otrosDestinos"]) {
        nacionales.add(
          Nacional(element["titulo"], element["ruta"])
        );
      }

      return nacionales;
    } else {
      throw Exception("Fallo la conexión en getNacionales");
    }
  }




  @override
  void initState() {
    super.initState();
    _listadoBestSellers = _getBestSellers();
    _listadoNews = _getNews();
    _listadoInternacionales = _getInternacionales();
    _listadoNacionales = _getNacionales();
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GoTravel', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,)),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 18,),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text("Mas Vendidos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),)
              ),
              const SizedBox(height: 18,),
              SizedBox(
                height: 450,
                child: FutureBuilder(
                  future: _listadoBestSellers, 
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 100,
                        child: CarouselView(
                            itemExtent: 400,
                            shrinkExtent: 0,
                            children: _listBestSellers(snapshot.data),),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Text("Error");
                    }
              
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18,),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text("Novedades", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),)
              ),
              const SizedBox(height: 18,),
              FutureBuilder(
                future: _listadoNews,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: _listNews(snapshot.data),
                      );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text("Error en novedades");
                  }
          
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 18,),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text("Destinos internacionales", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 25,),
              FutureBuilder(
                future: _listadoInternacionales, 
                builder: (context, inter) {
                  if (inter.hasData) {
                    return SizedBox(
                      height: 300,
                      child: ListView(
                          children: _listInternacionales(inter.data),
                        ),
                    );
                    
                  } else if (inter.hasError) {
                    print(inter.error);
                    return const Text("Error en el else");
                  }
          
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 18,),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text("Destinos nacionales", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 25,),
              FutureBuilder(
                future: _listadoNacionales, 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 300,
                      child: ListView(
                        children: _listNacionales(context ,snapshot.data),
                      ),
                    );

                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text("Error en el else");
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )

            ],
          ),
        )
      ),
    );
  }














  List<Widget> _listBestSellers(data){
    List<Widget> bestSellers = [];

    for (var element in data) {
      bestSellers.add(
        SizedBox(
          child: Card(
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(element.url, fit: BoxFit.fill, height: 430,),
              ],
            ),
          ),
        )
      );
    }

    return bestSellers;
  }


  List<Widget> _listNews(data) {
    List<Widget> news = [];

    for (var element in data) {
      news.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Image.network(element.url, height: 200,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(element.name, softWrap: true, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            )
          ),
        ),
      );  
    }

    return news;
  }

  
  List<Widget> _listInternacionales(data) {
    List<Widget> internacionales = [];

    for (var element in data) {
      internacionales.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.grey.shade300,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(element.titulo, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                const Row(
                  children: [
                    Text("Saber mas", style: TextStyle(fontSize: 14 ,color: Colors.black, fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios, color: Colors.orange,)
                  ],
                )
              ],
            ),
          ),
        )
      );
    }

    return internacionales;
  }


  List<Widget> _listNacionales(context, data) {
    List<Widget> nacionales = [];

    for (var element in data){ 
      nacionales.add(
        Padding(
          padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
          child: ListTile(
            hoverColor: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.grey.shade300,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(element.titulo, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                const Row(
                  children: [
                    Text("Saber mas", style: TextStyle(fontSize: 14 ,color: Colors.black, fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios, color: Colors.orange,)
                  ],
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => Travels(data: element.ruta),
                )
              );
            },
          ),
        ),
      );
    }

    return nacionales;
  }
  




}