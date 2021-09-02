import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterappnavigation/constan.dart';
import 'package:flutterappnavigation/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionsRepository({ Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      //'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&waypoints=via:31.4157%2C34.3415%7Cvia:31.4140%2C34.3395&key="AIzaSyBm-bSOgvL17sfF6sm4SO8EDHrEf9aYLk4"'
     _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key':'AIzaSyBm-bSOgvL17sfF6sm4SO8EDHrEf9aYLk4',
      },
    );


    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null!;
  }
}
