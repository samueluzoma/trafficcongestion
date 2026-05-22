// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'traffic_bloc.dart';

// class PredictionForm extends StatefulWidget {
//   @override
//   _PredictionFormState createState() => _PredictionFormState();
// }

// class _PredictionFormState extends State<PredictionForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _selectedDay = 'Monday';
//   final TextEditingController _cars = TextEditingController();
//   final TextEditingController _bikes = TextEditingController();
//   final TextEditingController _buses = TextEditingController();
//   final TextEditingController _trucks = TextEditingController();

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       final total = int.parse(_cars.text) + int.parse(_bikes.text) + 
//                     int.parse(_buses.text) + int.parse(_trucks.text);

//       final input = {
//         "Day of the week": _selectedDay,
//         "CarCount": int.parse(_cars.text),
//         "BikeCount": int.parse(_bikes.text),
//         "BusCount": int.parse(_buses.text),
//         "TruckCount": int.parse(_trucks.text),
//         "Total": total // Calculating total as expected by the model [cite: 13]
//       };
      
//       context.read<TrafficBloc>().add(PredictTraffic(input));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DropdownButtonFormField<String>(
//                 value: _selectedDay,
//                 items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
//                     .map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
//                 onChanged: (val) => setState(() => _selectedDay = val!),
//                 decoration: InputDecoration(labelText: "Day of the Week"),
//               ),
//               _buildField(_cars, "Car Count"),
//               _buildField(_bikes, "Bike Count"),
//               _buildField(_buses, "Bus Count"),
//               _buildField(_trucks, "Truck Count"),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: _submit, child: Text("Predict Traffic")),
//               SizedBox(height: 20),
//               _buildResultDisplay(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(TextEditingController controller, String label) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//       keyboardType: TextInputType.number,
//       validator: (val) => val!.isEmpty ? "Enter value" : null,
//     );
//   }

//   Widget _buildResultDisplay() {
//     return BlocBuilder<TrafficBloc, TrafficState>(
//       builder: (context, state) {
//         if (state is TrafficLoading) return CircularProgressIndicator();
//         if (state is TrafficLoaded) {
//           return Column(
//             children: [
//               Text("Result: ${state.result}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               Text("Confidence: ${state.confidence}"),
//             ],
//           );
//         }
//         if (state is TrafficError) return Text(state.message, style: TextStyle(color: Colors.red));
//         return Container();
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'traffic_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PredictionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analyze Road Condition"), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black),
      body: PredictionForm(),
    );
  }
}

class PredictionForm extends StatefulWidget {
  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDay = 'Monday';
  final TextEditingController _cars = TextEditingController();
  final TextEditingController _bikes = TextEditingController();
  final TextEditingController _buses = TextEditingController();
  final TextEditingController _trucks = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      int total = int.parse(_cars.text) + int.parse(_bikes.text) + int.parse(_buses.text) + int.parse(_trucks.text);
      
      final input = {
        "Day of the week": _selectedDay,
        "CarCount": int.parse(_cars.text),
        "BikeCount": int.parse(_bikes.text),
        "BusCount": int.parse(_buses.text),
        "TruckCount": int.parse(_trucks.text),
        "Total": total 
      };
      context.read<TrafficBloc>().add(PredictTraffic(input));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDayPicker(),
            SizedBox(height: 20),
            _buildInputCard(Icons.directions_car, "Cars", _cars, Colors.blue),
            _buildInputCard(Icons.pedal_bike, "Bikes", _bikes, Colors.orange),
            _buildInputCard(Icons.directions_bus, "Buses", _buses, Colors.green),
            _buildInputCard(Icons.local_shipping, "Trucks", _trucks, Colors.red),
            SizedBox(height: 30),
            _buildPredictButton(),
            SizedBox(height: 30),
            _buildResultDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(IconData icon, String label, TextEditingController controller, Color color) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label, border: InputBorder.none),
          validator: (val) => val!.isEmpty ? "Required" : null,
        ),
      ),
    );
  }

  Widget _buildDayPicker() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonFormField<String>(
        value: _selectedDay,
        items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
            .map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
        onChanged: (val) => setState(() => _selectedDay = val!),
        decoration: InputDecoration(border: InputBorder.none, labelText: "Select Day"),
      ),
    );
  }

  Widget _buildPredictButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [Colors.blue.shade900, Colors.blue.shade600]),
      ),
      child: TextButton(
        onPressed: _submit,
        child: Text("Predict Now", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return BlocBuilder<TrafficBloc, TrafficState>(
      builder: (context, state) {
        if (state is TrafficLoading) return SpinKitThreeBounce(color: Colors.blue, size: 30);
        if (state is TrafficLoaded) {
          return Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: state.result.contains('heavy') ? Colors.red.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: state.result.contains('heavy') ? Colors.red : Colors.green),
            ),
            child: Column(
              children: [
                Text(state.result.toUpperCase(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: state.result.contains('heavy') ? Colors.red : Colors.green)),
                Text("AI Confidence: ${state.confidence}", style: TextStyle(color: Colors.black54)),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}