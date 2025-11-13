import 'package:flutter/material.dart';
import 'package:tablet_app/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          children: [
            Container(
              width: 500,
              color: Colors.blue[800],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Search', style: TextStyle(color: Colors.white)),
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title Keyword'),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Keyword (1 - 10 charcater)',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text('Country Keyword'),
                  TextField(
                    controller: countryController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Keyword (1 - 10 charcater)',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text('Start Date'),
                  TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'MM/dd/yyyy (e.g. 03/21/2025)',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text('End Date'),
                  TextField(
                    controller: endDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'MM/dd/yyyy (e.g. 03/21/2025)',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SearchResult(
                      title: titleController.text,
                      countryName: countryController.text,
                      startDate: startDateController.text,
                      endDate: endDateController.text,
                    ),
                  ),
                );
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
