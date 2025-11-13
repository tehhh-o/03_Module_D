import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tablet_app/module/news.dart';
import 'package:tablet_app/news_article.dart';
import 'package:tablet_app/temp.dart';

class SearchResult extends StatefulWidget {
  final String title;
  final String countryName;
  final String startDate;
  final String endDate;

  const SearchResult({
    super.key,
    required this.title,
    required this.countryName,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  int totalItem = 0;
  late Future<List<News>> futureAllNews;
  bool openDrawer = false;

  Future<List<News>> getAllNews() async {
    final json = await rootBundle.loadString('assets/json/news.json');
    final body = jsonDecode(json);
    final news = body['news'].map<News>(News.fromjson).toList();

    return news;
  }

  @override
  void initState() {
    futureAllNews = getAllNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        leading: GestureDetector(
          onTap: () {
            setState(() {
              openDrawer = openDrawer == false ? true : false;
              ;
            });
          },
          child: Icon(Icons.menu),
        ),
        title: Row(
          children: [
            Image.asset('assets/medias/asean_logo.png', height: 40),
            SizedBox(width: 10),
            Text(
              'ASEAN Summit Digital Hub',
              style: TextStyle(color: Colors.white),
            ),
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
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Card(
                  color: Colors.yellow[400],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Found $totalItem result'),
                  ),
                ),
              ),

              FutureBuilder(
                future: futureAllNews,
                builder: (context, snapshot) {
                  if (snapshot.data!.isEmpty) {
                    return Text('No data');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final allNews = snapshot.data!;
                  final fna = allNews.where(
                    (n) => n.title.toLowerCase().contains(
                      widget.title.toLowerCase(),
                    ),
                  );
                  final fn = fna.where(
                    (n) => n.country.toLowerCase().contains(
                      widget.countryName.toLowerCase(),
                    ),
                  );
                  List<News> filteredNews = [];

                  for (News n in fn) {
                    filteredNews.add(n);
                  }
                  totalItem = filteredNews.length;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredNews.length,
                      itemBuilder: (context, index) {
                        final news = filteredNews[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return NewsArticle(news: news);
                                },
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Text(news.title),
                                  ListTile(
                                    leading: Icon(Icons.calendar_month),
                                    title: Text(news.display_time),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.location_pin),
                                    title: Text(news.country),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.contact_page),
                                    title: Text('Article ID : ${news.id}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          openDrawer ? TempDrawer() : SizedBox(),
        ],
      ),
    );
  }
}
