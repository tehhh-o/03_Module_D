import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tablet_app/main.dart';
import 'package:tablet_app/module/country.dart';
import 'package:tablet_app/news_list.dart';
import 'package:tablet_app/search.dart';

class TempDrawer extends StatefulWidget {
  const TempDrawer({super.key});

  @override
  State<TempDrawer> createState() => TempDrawerState();
}

class TempDrawerState extends State<TempDrawer> {
  late Future<List<Country>> futureCountry;
  late int selectedCountry = -1;

  Future<List<Country>> getCountry() async {
    final json = await rootBundle.loadString('assets/json/countries.json');
    final body = jsonDecode(json);
    final country = body['countries'].map<Country>(Country.fromJson).toList();

    return country;
  }

  @override
  void initState() {
    futureCountry = getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 250,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 250,
            color: Colors.blue[800],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/medias/asean_logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),

                Text(
                  'ASEAN Summit 2026',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icon(Icons.home),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SearchPage();
                  },
                );
              },
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('search'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          FutureBuilder(
            future: futureCountry,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              final countries = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCountry == index
                              ? selectedCountry = -1
                              : selectedCountry = index;
                        });
                      },
                      child: CountryTile(
                        country: country,
                        selectedCountry: selectedCountry,
                        index: index,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CountryTile extends StatelessWidget {
  final int selectedCountry;
  final int index;
  final Country country;
  const CountryTile({
    super.key,
    required this.country,
    required this.selectedCountry,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(country.name),
                  trailing: selectedCountry == index
                      ? Icon(Icons.arrow_drop_up)
                      : Icon(Icons.arrow_drop_down),
                ),
              ),
            ],
          ),
          selectedCountry != index
              ? SizedBox()
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsList(
                              country: country,
                              topicSelected: country.topics[0],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(country.topics[0]),
                      ),
                    ),
                    Container(decoration: BoxDecoration(border: Border.all())),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsList(
                              country: country,
                              topicSelected: country.topics[1],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(country.topics[1]),
                      ),
                    ),
                    Container(decoration: BoxDecoration(border: Border.all())),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsList(
                              country: country,
                              topicSelected: country.topics[2],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(country.topics[2]),
                      ),
                    ),
                    Container(decoration: BoxDecoration(border: Border.all())),
                  ],
                ),
        ],
      ),
    );
  }
}
