import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RateUsPage extends StatefulWidget {
  @override
  _RateUsPageState createState() => _RateUsPageState();
}

class _RateUsPageState extends State<RateUsPage> {
  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We would love to hear from you!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Please take a moment to rate your experience with our app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStars = index + 1;
                    });
                    // Handle the rating here, e.g., submit to a database
                  },
                  child: Icon(
                    index < _selectedStars ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.green,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Thank you!! We will  improve our performance");
                    },
                    child: Text("Submit")))
          ],
        ),
      ),
    );
  }
}
