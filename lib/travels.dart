import 'dart:convert';

import 'package:app_travels/models/travel.dart';
import 'package:app_travels/travelDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Travels extends StatefulWidget {
  final String data;

  const Travels({required this.data});

  @override
  State<Travels> createState() => _TravelsState();
}

class _TravelsState extends State<Travels> {
  late String receivedData;

  late Future<List<Travel>> _listadoTravels;


  Future<List<Travel>> _getTravels() async {
    // URL de la API
    final url = Uri.parse('https://www.api.salonnefertaritravel.com/api/getTripsBySlug/$receivedData');

    // Encabezado
    final headers = {
      'x-api-key': '0d0e1d-cc8d04-ecd55e-a346e5-6e2ebc',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    List<Travel> travels = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var element in jsonData["viajes"]) {
        travels.add(
          Travel(element["nombre"], element["desde"], element["imagen"], element["dias"], element["noches"], element["enlace"])
        );
      }

      return travels;
    } else {
      throw Exception("Fallo la conexión");
    }
  }
  


  @override
  void initState() {
    super.initState();
    receivedData = widget.data;
    _listadoTravels = _getTravels();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        useMaterial3: true,
        /*scaffoldBackgroundColor: Color.fromARGB(255, 156, 205, 219),//Color.fromARGB(255, 179, 183, 146),Color.fromARGB(255, 247, 254, 239),*/
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.arrow_back, size: 35,)
          ),
          title: Text('GoTravel', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,)),
          centerTitle: true,
          backgroundColor: Colors.orange,//Color.fromARGB(255, 6, 69, 105),Color.fromARGB(255, 114, 92, 58),//Color.fromARGB(255, 151, 183, 112),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _listadoTravels, 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: _listTravels(context, snapshot.data),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text("Error aqui");
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          )
        )
      ),
    );
  }

  List<Widget> _listTravels(context, data) {
    List<Widget> travels = [];

    for (var element in data) {
      travels.add(
        GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: Card(
              color: Colors.grey.shade300,//Color.fromARGB(255, 208, 215, 225),//Color.fromARGB(255, 128, 150, 113),//Color.fromARGB(255, 203, 221, 181),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(element.image, width: MediaQuery.of(context).size.width*0.65,),
                  ),
                  Text(element.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.sunny),
                            const SizedBox(width: 5,),
                            Text('Dias: ${element.days}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.nightlight),
                            const SizedBox(width: 5,),
                            Text('Noches: ${element.nights}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Desde \$${element.cost}', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TravelsDetails(data: element.rute),
              )
            );
          },
        )
      );
    }

    return travels;
  }



}