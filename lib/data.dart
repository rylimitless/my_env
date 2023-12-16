import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataAppView extends StatefulWidget{
  State<DataAppView> createState()=> _DataViewState();
}

class _DataViewState extends State<DataAppView>{
  Future<Map<String, dynamic>> fetchWeatherData() async {
  final response = await http.get(Uri.parse('http://localhost:8000/'));
  
  if (response.statusCode == 200) {
    return {"It's": "working"};
  } else {
    throw Exception('Failed to load weather data');
  }
}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: const Center(
        child: const Text("Data charts and AI analysis will be displayed here"),
      ),
    );
  }
}