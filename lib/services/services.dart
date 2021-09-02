import 'dart:convert';
import 'package:flutterappnavigation/constan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

getTop10FaildLoginState(Context) async {
  var url = Uri.parse(
      'https://actplustechpopsadranwebhost20210812232708.azurewebsites.net/api/services/app/Routes/GetStationsofRoute?IdofRoute=1');
  Map headerMap = {
    'Authorization':
 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQWJhZGFsbGFoIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiQUJBREFMTEFIQEZNQUlMLkNPTSIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiTk5QVU1RNks0TU0yWU1KSEdLN1daNE5JRVUzQVRMWkUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsInN1YiI6IjMiLCJqdGkiOiIwZjM0ODllZS01NDVhLTQxOTYtODQ2ZS0wZTg5Y2JkMmUyOWYiLCJpYXQiOjE2MzA1ODcxOTAsInRva2VuX3ZhbGlkaXR5X2tleSI6IjczYjkwZjU2LTYyYmYtNDRlOS04YWRjLWRkNjU2MDFmODcyMCIsInVzZXJfaWRlbnRpZmllciI6IjMiLCJ0b2tlbl90eXBlIjoiMCIsInJlZnJlc2hfdG9rZW5fdmFsaWRpdHlfa2V5IjoiY2E0YjU2MmItOGUwNi00OTAyLTkxM2MtMjY5YTA2MTFjNzNhIiwibmJmIjoxNjMwNTg3MTkwLCJleHAiOjE2MzA2NzM1OTAsImlzcyI6IlBPUFNhZHJhbiIsImF1ZCI6IlBPUFNhZHJhbiJ9.D1lAnmR2fpqQts8sJZyBcJ0VSgKV27AZ1N4vopnutBw'

  };
  try {
    http.Response response = await http.get(url, headers: {...headerMap});
    print(response.body);
    // assert(response.statusCode!=200);
    List responseMap = json.decode(response.body)['result']['items'];
    print(responseMap.length);
    for (int x = 0; x < responseMap.length; x++) {
      var m = LatLng(responseMap[x]['station']['station']['latitude'],
          responseMap[x]['station']['station']['longitude']);
      Constant.constant.listMarker.add(m);
    }

    Constant.constant.My_DEST_LOCATION = LatLng(
        Constant.constant.listMarker.last.latitude,
        Constant.constant.listMarker.last.longitude);
    Constant.constant.My_SOURCE_LOCATION = LatLng(
        Constant.constant.listMarker.first.latitude,
        Constant.constant.listMarker.first.longitude);
  } on Exception catch (e) {
    print('error:$e');
  }
}

getStationState(Context) async {
  var url = Uri.parse(
      'https://actplustechpopsadranwebhost20210812232708.azurewebsites.net/api/services/app/Shapes/GetAll?MaxResultCount=3000');
  Map headerMap = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQWJhZGFsbGFoIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiQUJBREFMTEFIQEZNQUlMLkNPTSIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiTk5QVU1RNks0TU0yWU1KSEdLN1daNE5JRVUzQVRMWkUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsInN1YiI6IjMiLCJqdGkiOiIwZjM0ODllZS01NDVhLTQxOTYtODQ2ZS0wZTg5Y2JkMmUyOWYiLCJpYXQiOjE2MzA1ODcxOTAsInRva2VuX3ZhbGlkaXR5X2tleSI6IjczYjkwZjU2LTYyYmYtNDRlOS04YWRjLWRkNjU2MDFmODcyMCIsInVzZXJfaWRlbnRpZmllciI6IjMiLCJ0b2tlbl90eXBlIjoiMCIsInJlZnJlc2hfdG9rZW5fdmFsaWRpdHlfa2V5IjoiY2E0YjU2MmItOGUwNi00OTAyLTkxM2MtMjY5YTA2MTFjNzNhIiwibmJmIjoxNjMwNTg3MTkwLCJleHAiOjE2MzA2NzM1OTAsImlzcyI6IlBPUFNhZHJhbiIsImF1ZCI6IlBPUFNhZHJhbiJ9.D1lAnmR2fpqQts8sJZyBcJ0VSgKV27AZ1N4vopnutBw'
  };
  try {
    http.Response response = await http.get(url, headers: {...headerMap});
    print(response.body);
    // assert(response.statusCode!=200);
    List responseMap = json.decode(response.body)['result']['items'];
    print(responseMap.length);
    for (int x = 0; x < responseMap.length; x++) {
      var m = LatLng(responseMap[x]['shape']['shape_pt_lat'],
          responseMap[x]['shape']['shape_pt_lon']);
      Constant.constant.listShapeLatLng.add(m);
    }
  } on Exception catch (e) {
    print('error:$e');
  }
}
