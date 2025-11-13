import 'package:flutter/material.dart';
import 'package:tablet_app/temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScaffoldState scaffoldState = ScaffoldState();
  bool openDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        leading: GestureDetector(
          onTap: () {
            setState(() {
              openDrawer = openDrawer == false ? true : false;
            });
          },
          child: Icon(Icons.menu),
        ),
        title: Row(
          children: [
            Image.asset('assets/medias/asean_logo.png', height: 40),
            SizedBox(width: 10),
            Text('Digital Hub', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/medias/main_banner.png',
                  fit: BoxFit.fitWidth,
                  height: 200,
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Image.asset('assets/medias/asean_logo.png', height: 150),
              ),

              Text(
                'ASEAN Digital Hub',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your gateway to summit updates and\nnews',
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 2,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        height: 2,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 3),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 3),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Text(
                'Your gateway to ASEAN Summit updates, news,\nand media resources',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          openDrawer ? TempDrawer() : SizedBox(),
        ],
      ),
      drawer: Drawer(
        child: Row(children: [ListTile(title: Text('test'))]),
      ),
    );
  }
}
