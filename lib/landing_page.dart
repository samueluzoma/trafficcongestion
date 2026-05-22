import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'prediction_form.dart';

class LandingPage extends StatelessWidget {
  final List<Map<String, String>> sliderData = [
    {"title": "Real-time Analysis", "desc": "Predict congestion using AI.", "img": "assets/traffic1.png"},
    {"title": "Plan Your Trip", "desc": "Know the traffic before you leave.", "img": "assets/traffic2.png"},
    {"title": "Smart Routing", "desc": "Avoid heavy traffic situations.", "img": "assets/traffic3.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60),
          CarouselSlider(
            options: CarouselOptions(height: 400.0, autoPlay: true, enlargeCenterPage: true),
            items: sliderData.map((data) {
              return Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade800]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insights, size: 80, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(data['title']!, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Text(data['desc']!, style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionScreen())),
                child: Text("Start Prediction", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}