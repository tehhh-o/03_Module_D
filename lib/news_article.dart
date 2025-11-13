import 'package:flutter/material.dart';
import 'package:tablet_app/module/news.dart';

class NewsArticle extends StatefulWidget {
  final News news;
  const NewsArticle({super.key, required this.news});

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  double fontChange = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 600,
        width: 500,
        child: Column(
          children: [
            Container(
              width: 500,
              color: Colors.blue[800],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'News Article',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Column(
                children: [
                  Text(widget.news.title),
                  ListTile(
                    leading: Icon(Icons.calendar_month),
                    title: Text(widget.news.display_time),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(widget.news.country),
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_page),
                    title: Text('Article ID : ${widget.news.id}'),
                  ),
                  Text(
                    widget.news.article,
                    style: TextStyle(fontSize: 16 + fontChange),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 500,
              color: Colors.yellow,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text('Text Size'),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        fontChange += 2;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        fontChange -= 2;
                      });
                    },
                    icon: Icon(Icons.linear_scale_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
