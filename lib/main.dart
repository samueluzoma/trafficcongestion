// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'service.dart';
// import 'traffic_bloc.dart';
// import 'prediction_form.dart';

// void main() {
//   runApp(const TrafficApp());
// }

// class TrafficApp extends StatelessWidget {
//   const TrafficApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Traffic Predictor',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: BlocProvider(
//         create: (context) => TrafficBloc(PredictionService()),
//         child: Scaffold(
//           appBar: AppBar(title: const Text("Traffic Congestion Prediction")),
//           body: PredictionForm(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service.dart';
import 'traffic_bloc.dart';
import 'splash_screen.dart';

void main() {
  runApp(const TrafficApp());
}

class TrafficApp extends StatelessWidget {
  const TrafficApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrafficBloc(PredictionService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Traffic AI',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: SplashScreen(),
      ),
    );
  }
}