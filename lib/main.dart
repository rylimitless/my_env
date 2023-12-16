import 'package:env_app/chat.dart';
import 'package:env_app/data.dart';
import 'package:env_app/home.dart';
import 'package:env_app/navBar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async{
  // await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Environment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var hum = 0.0;
  var temp = 0.0;
  var pres = 0.0;
  Timer? _timer;

    var _selectedIndex = 0;


  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) => _fetchData());
  }

  Future<void> _fetchData() async {
    // Make your API call here and update the state of your variables
    // For example:
    final response = await http.get(Uri.parse('http://localhost:8000/'));
        final data = jsonDecode(response.body);
    setState(() {
     hum = data['hum'];
      temp = data['temp'];
      pres = data['pre'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Center(child: Text(widget.title)),
      ),
      body: IndexedStack(
          index: _selectedIndex,
          children: [
              // DataView(),
              HomePage(pres: pres, hum: hum, temp: temp),
              DataAppView(),
              
              ChatScreen(),
          ],
      ),
    
      bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        onTap: (index){
          setState(() {
             _selectedIndex = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
