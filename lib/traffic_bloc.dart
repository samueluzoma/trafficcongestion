import 'package:flutter_bloc/flutter_bloc.dart';
import 'service.dart';

// Events
abstract class TrafficEvent {}
class PredictTraffic extends TrafficEvent {
  final Map<String, dynamic> inputData;
  PredictTraffic(this.inputData);
}

// States
abstract class TrafficState {}
class TrafficInitial extends TrafficState {}
class TrafficLoading extends TrafficState {}
class TrafficLoaded extends TrafficState {
  final String result;
  final String confidence;
  TrafficLoaded(this.result, this.confidence);
}
class TrafficError extends TrafficState {
  final String message;
  TrafficError(this.message);
}

// BLoC
class TrafficBloc extends Bloc<TrafficEvent, TrafficState> {
  final PredictionService service;

  TrafficBloc(this.service) : super(TrafficInitial()) {
    on<PredictTraffic>((event, emit) async {
      emit(TrafficLoading());
      try {
        final data = await service.getTrafficPrediction(event.inputData);
        // "prediction" and "confidence" keys come from your Flask app.py [cite: 11]
        emit(TrafficLoaded(data['prediction'], data['confidence']));
      } catch (e) {
        emit(TrafficError(e.toString()));
      }
    });
  }
}