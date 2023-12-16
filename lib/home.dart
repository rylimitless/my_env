import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  
  double pres;
  double hum;
  double temp;

  get humidity => hum;
  get pressure => pres;
  get temperature => temp;


  HomePage({required this.pres, required this.hum, required this.temp});
  State<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{

 

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SingleChildScrollView( child:  Column(
      children: <Widget>[
  
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            WeatherDisplay(icon: Icons.wb_sunny, temperature: 25, description: 'Sunny'),
            WeatherDisplay(icon: Icons.cloud, temperature: 20, description: 'Cloudy'),
            WeatherDisplay(icon: Icons.grain, temperature: 18, description: 'Windy'),
          ],
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < 2; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              WeatherBox(icon: Icons.thermostat, description: ' °C'),
              WeatherBox(icon: Icons.cloud, description: 'Cloudy'),
              WeatherBox(icon: Icons.grain, description: 'Windy'),
            ],
          ),
      ],
    ),
    ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final IconData icon;
  final int temperature;
  final String description;

  WeatherDisplay({required this.icon, required this.temperature, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 50),
        Text('$temperature°C'),
        Text(description),
      ],
    );
  }
}

class WeatherBox extends StatelessWidget {
  final IconData icon;
  final String description;

  WeatherBox({required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Icon(icon, size: 50),
              Text(description, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
