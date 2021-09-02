
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Constant {
  Constant._();
  static Constant constant = Constant._();
  String apiKey='';
  List<LatLng> listMarker = [];
  List<LatLng> listShapeLatLng = [];
  List<LatLng> mynewshape=[];
  List<LatLng> listpoint=[
    LatLng(31.529860, 34.467290),
    LatLng(31.539860, 34.557290),
    LatLng(31.549860, 34.757290),
    LatLng(31.519860, 34.457290),
  ];
 late LatLng My_DEST_LOCATION;
  late LatLng  My_SOURCE_LOCATION;
   String  TOKEN = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQWJhZGFsbGFoIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiQUJBREFMTEFIQEZNQUlMLkNPTSIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiTk5QVU1RNks0TU0yWU1KSEdLN1daNE5JRVUzQVRMWkUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsInN1YiI6IjMiLCJqdGkiOiIwZjM0ODllZS01NDVhLTQxOTYtODQ2ZS0wZTg5Y2JkMmUyOWYiLCJpYXQiOjE2MzA1ODcxOTAsInRva2VuX3ZhbGlkaXR5X2tleSI6IjczYjkwZjU2LTYyYmYtNDRlOS04YWRjLWRkNjU2MDFmODcyMCIsInVzZXJfaWRlbnRpZmllciI6IjMiLCJ0b2tlbl90eXBlIjoiMCIsInJlZnJlc2hfdG9rZW5fdmFsaWRpdHlfa2V5IjoiY2E0YjU2MmItOGUwNi00OTAyLTkxM2MtMjY5YTA2MTFjNzNhIiwibmJmIjoxNjMwNTg3MTkwLCJleHAiOjE2MzA2NzM1OTAsImlzcyI6IlBPUFNhZHJhbiIsImF1ZCI6IlBPUFNhZHJhbiJ9.D1lAnmR2fpqQts8sJZyBcJ0VSgKV27AZ1N4vopnutBw';
}