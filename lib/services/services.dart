import 'dart:convert';
import 'package:flutterappnavigation/constan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

getTop10FaildLoginState(Context) async {
  var url = Uri.parse(
      'https://actplustechpopsadranwebhost20210812232708.azurewebsites.net/api/services/app/Routes/GetStationsofRoute?IdofRoute=1');
  Map headerMap = {
    'Authorization':
    Constant.constant.TOKEN

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
        Constant.constant.TOKEN
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
