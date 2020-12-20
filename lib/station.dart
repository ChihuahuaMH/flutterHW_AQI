import 'dart:ffi';

class Station {
  String siteName;
  String county;
  String pollutant;
  String status;
  int aqi;
  int pm25;

  Station({this.siteName, this.county});

  Station.fromJson(Map<String, dynamic> json) {
    if (json['Pollutant'] != "") {
      pollutant = json['Pollutant'];
    } else {
      pollutant = "無";
    }
    
    siteName = json['SiteName'];
    county = json['County'];
    status = json['Status'];
    aqi = int.tryParse(json['AQI']) ?? -1;
    pm25 = int.tryParse(json['PM2.5']) ?? -1;
  }
}
