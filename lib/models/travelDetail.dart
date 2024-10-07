class TravelD {
  late String name;
  late int cost;
  late String image;
  late int days;
  late int nights;
  late String citys;
  late String desc;
  late int costDoble;
  late int costTriple;
  late int costSencilla;
  late int costJunior;
  late String moneda;
  late String date;

  TravelD({
    required this.name,
    required this.cost,
    required this.image,
    required this.days,
    required this.nights,
    required this.citys,
    required this.desc,
    required this.costDoble,
    required this.costTriple,
    required this.costSencilla,
    required this.costJunior,
    required this.moneda,
    required this.date,
  });

  // Método para convertir JSON a objeto Travel
  factory TravelD.fromJson(Map<String, dynamic> json) {
    return TravelD(
      name: json['nombre'],
      cost: json['desde'],
      image: json['imagen'],
      days: json['dias'],
      nights: json['noches'],
      citys: json['ciudades'],
      desc: json['descripcion'],
      costDoble: json['precio_doble'],
      costTriple: json['precio_triple'],
      costSencilla: json['precio_sencilla'],
      costJunior: json['precio_junior'],
      moneda: json['moneda'],
      date: json['fechas'][0]['fecha'],
    );
  }
}







/*class TravelDetail {
  late String name;
  late int cost;
  late String image;
  late int days;
  late int nights;
  late String citys;
  late String desc;
  late int costDoble;
  late int costTriple;
  late int costSencilla;
  late int costJunior;
  late String moneda;
  late String date;

  TravelDetail(name, cost, image, days, nights, citys, desc, costDoble, costTriple, costSencilla, costJunior, moneda, date){
    this.name = name;
    this.cost = cost;
    this.image = image;
    this.days = days;
    this.nights = nights;
    this.citys = citys;
    this.desc = desc;
    this.costDoble = costDoble;
    this.costTriple = costTriple;
    this.costSencilla = costSencilla;
    this.costJunior = costJunior;
    this.moneda = moneda;
    this.date = date;
  }
}*/
