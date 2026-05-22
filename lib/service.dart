import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
final String baseUrl = "https://traffic-congestion-prediction-krrf.onrender.com/predict";

  Future<Map<String, dynamic>> getTrafficPrediction(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to get prediction: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error connecting to API: $e");
    }
  }
}