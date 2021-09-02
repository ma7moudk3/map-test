class StationModel {
  late String locationName;
  late double latitude;
  late double longitude;
  late bool isStop;
  late int stationCode;
  late String locationNameHebrew;
  late  String type;
  late bool isMark;
  late bool isSave;
  late  int checkDistance;
  late  bool isPath;
  late int id;

  StationModel(
      {required this.locationName,
        required this.latitude,
        required this.longitude,
        required this.isStop,
        required this.stationCode,
        required this.locationNameHebrew,
        required this.type,
        required this.isMark,
        required this.isSave,
        required this.checkDistance,
        required this.isPath,
        required this.id});

  StationModel.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isStop = json['isStop'];
    stationCode = json['stationCode'];
    locationNameHebrew = json['locationNameHebrew'];
    type = json['type'];
    isMark = json['isMark'];
    isSave = json['isSave'];
    checkDistance = json['checkDistance'];
    isPath = json['isPath'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationName'] = this.locationName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isStop'] = this.isStop;
    data['stationCode'] = this.stationCode;
    data['locationNameHebrew'] = this.locationNameHebrew;
    data['type'] = this.type;
    data['isMark'] = this.isMark;
    data['isSave'] = this.isSave;
    data['checkDistance'] = this.checkDistance;
    data['isPath'] = this.isPath;
    data['id'] = this.id;
    return data;
  }
}