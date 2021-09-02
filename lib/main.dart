import 'dart:collection';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutterappnavigation/assistant/directions_repository.dart';
import 'package:flutterappnavigation/constan.dart';
import 'package:flutterappnavigation/input_key.dart';
import 'package:flutterappnavigation/models/directions_model.dart';
import 'package:flutterappnavigation/splash.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'components/map_pin_pill.dart';
import 'models/pin_pill_info.dart';
const double CAMERA_ZOOM = 20;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 10;
const LatLng SOURCE_LOCATION = LatLng(31.413465, 34.249650);
LatLng DEST_LOCATION =LatLng(31.784232,35.228601);
late List<LatLng> listpoint=[];
void main() {
  runApp(
      GetMaterialApp(home: MaterialApp(debugShowCheckedModeBanner: false, home:Splash()))
  );
}

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}
class MapPageState extends State<MapPage> {
  bool check=false;
  bool checkDistance=false;
  Directions? _info;
   String durationRide='';
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  var myMarker=HashSet<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<Polyline> myployine=[];
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  String googleAPIKey ='AIzaSyBm-bSOgvL17sfF6sm4SO8EDHrEf9aYLk4';
      //'AIzaSyBm-bSOgvL17sfF6sm4SO8EDHrEf9aYLk4';
// for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late LocationData currentLocation;

  List<double> lats = [];
  List<double> longs = [];
  List<double> filteredLats = [];
  List<double> filteredLongs = [];

// a reference to the destination location
  late LocationData destinationLocation;
// wrapper around the location API
  late Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;


  CreatePolyline(){
    print("Length Constant.constant.listShapeLatLng ${Constant.constant.listShapeLatLng.length}");

    for(int i =0;i < Constant.constant.listShapeLatLng.length;i++){
      lats.add(Constant.constant.listShapeLatLng[i].latitude);
      longs.add((Constant.constant.listShapeLatLng[i].longitude));
    }
    print("Length lats ${lats.length}");
    print("Length longs ${longs.length}");

    double totalDistance = 0;
    int index = 0;
    for(var i = index; i < lats.length-1; i++){
      totalDistance += calculateDistance(lats[index], longs[index], lats[index+1], longs[index+1]) ;
      if ((totalDistance*1000) >=40){
        filteredLats.add(lats[index]);
        filteredLats.add(lats[i]);
        filteredLongs.add(longs[index]);
        filteredLongs.add(longs[i]);
        index = i;
        print("Total ${totalDistance*1000}");
        totalDistance = 0;
      }

    }
    print("Length filteredLats ${filteredLats.length}");

    List<LatLng> filteredLatLong = [];
    for(var i = 0; i < filteredLats.length-1; i++){
      filteredLatLong.add(LatLng(filteredLats[i], filteredLongs[i]));
    }
    print("Length filteredLatLong ${filteredLatLong.length}");


    myployine.add(
      Polyline(
          polylineId:PolylineId('1'),
          color: Colors.blue,
          width: 4,
         points:filteredLatLong,
      ),
    ) ;

  }
  @override
  void initState() {
    super.initState();
    listpoint=Constant.constant.listMarker;
    //MyNotificationApi.init();
    CreatePolyline();

   // DEST_LOCATION=LatLng(listpoint.last.latitude,listpoint.last.longitude);
    print('////////////////////////////////////////////////////');
    print(listpoint.length);
    print('////////////////////////////////////////////////////');
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();
    location.onLocationChanged().listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
    // LatLng oldPos=LatLng(0, 0);
    // oldPos=LatLng(currentLocation.latitude,currentLocation.longitude);
    // ubdateRideDirection();
    print(Constant.constant.apiKey);
    Constant.constant.listMarker.map((e) {
      e.longitude==currentLocation.longitude && e.latitude==currentLocation.latitude?check=true
          :check=false;
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((e.latitude - currentLocation.latitude) * p) / 2 +
          c(currentLocation.latitude * p) *
              c(e.latitude * p) *
              (1 - c((e.longitude - currentLocation.longitude) * p)) /
              2;
      double distance = 12742 * asin(sqrt(a))*1000;
      // print('distance print(distance); print(distance); print(distance');
      // print(distance);
      // print('distance print(distance); print(distance); print(distance');
      distance<50&&distance>0?checkDistance=true:checkDistance=false;
    });


  }
  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destination_map_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation()  {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    //currentLocation = await location.getLocation();
    //currentLocation =SOURCE_LOCATION;
    // hard-coded destination for this example

    currentLocation = LocationData.fromMap({
      "latitude": SOURCE_LOCATION.latitude,
      "longitude": SOURCE_LOCATION.longitude

    });
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
      // "latitude":  listpoint.last.latitude,
      // "longitude":  listpoint.last.longitude,
    });

  // var rot=MapKitAssistant.getMarkerRotaion(oldPos.latitude, oldPos.longitude, currentLocation.latitude, currentLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    listpoint=Constant.constant.listMarker;
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );
    if (currentLocation != null) {
      print(currentLocation);
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom:CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(AddBlocRangIP());
        },
        child: Icon(Icons.settings),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines:myployine.toSet(),
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              },
              onMapCreated: (GoogleMapController controller) {
                for(int x=0;x<listpoint.length-1;x++){
                  print('///////////////////////Constant.constant.listMarker.////////////////////');
                  print('main${Constant.constant.listMarker}');
                  print('///////////////////////////////////////////');
                  _markers.add(Marker(
                    markerId: MarkerId('$x'),
                    position: listpoint[x],
                  ));
                }
                //controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);
                // my map has completed being created;
                // i'm ready to show the pins on the map
              showPinsOnMap();
              }
              ),
          MapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPin: currentlySelectedPin),
          _info != null? Positioned(
            bottom:0,
            child: Container(
                width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.25,
              color: Colors.white,
              margin:  EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Direction: ',style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                          Text(
                            'Please Move ${_info!.myManeuver}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 40,),
                              _info!.myManeuver=='turn-right'? Icon(Icons.arrow_forward_sharp,size: 30,color: Colors.grey.shade700,)
                              :_info!.myManeuver=='turn-left'? Icon(Icons.arrow_back,size: 30,color:Colors.grey.shade700,)
                              :_info!.myManeuver=='straight'?Icon(Icons.arrow_upward_sharp,size: 30,color: Colors.grey.shade700,):Container(),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        children: [
                          Text('Distance: ',style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                          Text(
                            '${_info!.totalDistance}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Text('Remaining Time: ',style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),),
                          Text(
                            '${_info!.totalDuration}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )
          ):Container(),

          check==true? Positioned(
            top: 25,
            left: 2,
            right: 2,
            child: AlertDialog(
              backgroundColor: Colors.grey.shade200,
              title:  Center(
                child: Text('STATION INFO',style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 22,
                ),),
              ),
              insetPadding: EdgeInsets.only(left: 4,right: 4,),
              content:   Container(
                width: 400,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('There is a station 50 meters away',style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 18,
                    ),),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK',style: TextStyle(
                      fontSize:18
                  ),),
                  onPressed: () {
                    Get.to(MapPage());
                  },
                ),],
            ),
          ):Container(),
          checkDistance==true? Positioned(
            top: 25,
            left: 2,
            right: 2,
            child: AlertDialog(
              backgroundColor: Colors.grey.shade200,
              title:  Center(
                child: Text('STATION INFO',style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 22,
                ),),
              ),
              insetPadding: EdgeInsets.only(left: 4,right: 4,),
              content:   Container(
                width: 400,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('There is a station 50 meters away',style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 18,
                    ),),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK',style: TextStyle(
                      fontSize:18
                  ),),
                  onPressed: () {
                    Get.to(MapPage());
                  },
                ),],
            ),
          ):Container(),
        ],
      ),
    );
  }
  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(destinationLocation.latitude, destinationLocation.longitude);
    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
       // location:Constant.constant.polylineCoordinates.first,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);
    destinationPinInfo = PinInformation(
        locationName: "End Location",
    location: DEST_LOCATION,
      //  location: Constant.constant.My_DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);
    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = destinationPinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon));

    // set the route lines on the map from source to destination
    // for more info follow this tutorial
   // setPolylines();
  }

  // void setPolylines() async {
  //   List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPIKey,
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       destinationLocation.latitude,
  //       destinationLocation.longitude);
  //
  //   if (result.isNotEmpty) {
  //     // result.forEach((PointLatLng point) {
  //     //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     // });
  //     var lats = [];
  //     var longs = [];
  //     for(int i = 0 ; i< filteredLats.length;i++){
  //       polylineCoordinates.add(LatLng(filteredLats[i], filteredLongs[i]));
  //     }
  //     print("Length polylineCoordinates ${polylineCoordinates.length}");
  //     setState(() {
  //       _polylines.add(Polyline(
  //           width: 2, // set the width of the polylines
  //           polylineId: PolylineId("poly"),
  //           color: Color.fromARGB(255, 40, 122, 198),
  //           points: polylineCoordinates));
  //     });
  //   }
  // }

  // void filterPointsOnDistance() async{
  //   DirectionsRepository directionsRepository = DirectionsRepository();
  //   for(int i =0; i < Constant.constant.listMarker.length ; i++){
  //     for(int j =1; i < Constant.constant.listMarker.length ; i++){
  //      var directions = await directionsRepository.getDirections(origin: Constant.constant.listMarker[i], destination: Constant.constant.listMarker[j]);
  //      //directions
  //     }
  //   }
  //
  // }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }



  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
      LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });

    final directions = await DirectionsRepository()
        .getDirections(origin:LatLng(currentLocation.latitude, currentLocation.longitude),
        destination:LatLng(destinationLocation.latitude, destinationLocation.longitude));
    setState(() => _info = directions);}
}

