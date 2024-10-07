import 'package:app_travels/models/travelController.dart';
import 'package:app_travels/models/travelDetail.dart';
import 'package:flutter/material.dart';

class TravelsDetails extends StatefulWidget {
  final String data;

  const TravelsDetails({required this.data});

  @override
  State<TravelsDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelsDetails> {
  late Future<TravelD> _travelDetails;

  

  @override
  void initState() {
    super.initState();
    _travelDetails = fetchTravelDetails(widget.data);
    print(fetchTravelDetails(widget.data));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        useMaterial3: true,
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
          title: const Text('GoTravel', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _travelDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasData) {
                final TravelD = snapshot.data!;

                //Verificar si el valor es 0
                final String costJText = TravelD.costJunior == 0 ? 'No especificado' : '\$${TravelD.costJunior} ${TravelD.moneda}';
                final String costSText = TravelD.costSencilla == 0 ? 'No especificado' : '\$${TravelD.costSencilla} ${TravelD.moneda}';
                final String costDText = TravelD.costDoble == 0 ? 'No especificado' : '\$${TravelD.costDoble} ${TravelD.moneda}';
                final String costTText = TravelD.costTriple == 0 ? 'No especificado' : '\$${TravelD.costTriple} ${TravelD.moneda}';


                return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(TravelD.image),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Text(TravelD.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1,),)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 5,),
                        const Text('Ciudades: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Expanded(child: Text(TravelD.citys, style: const TextStyle(fontSize: 20))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.sunny),
                        const SizedBox(width: 5,),
                        const Text('Dias: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text('${TravelD.days}', style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.nightlight),
                        const SizedBox(width: 5,),
                        const Text('Noches: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text('${TravelD.nights}', style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5,),
                        const Text('Precio sencillo: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text(costSText, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.people),
                        const SizedBox(width: 5,),
                        const Text('Precio doble: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text(costDText, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.groups),
                        const SizedBox(width: 5,),
                        const Text('Precio triple: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text(costTText, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.child_care),
                        const SizedBox(width: 5,),
                        const Text('Precio junior: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text(costJText, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.date_range),
                        const SizedBox(width: 5,),
                        const Text("Fecha: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 15,),
                        Text(TravelD.date, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    const Row(
                      children: [
                        Icon(Icons.description),
                        const SizedBox(width: 5,),
                        Text("Descripción: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text(TravelD.desc, style: const TextStyle(fontSize: 20),),
                  ],
                ),
              );
              }
              return const Center(child: Text('Sin datos'),);
            },
          ),
        )
      ),
    );
  }
}