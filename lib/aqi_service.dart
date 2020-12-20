import 'dart:convert';
import 'package:http/http.dart' as http;

import 'station.dart';

Future<List<Station>> fetchAQI() async {
  final response = await http.get(
      'https://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?sort=County&offset=0&limit=1000');

  print('response gotten');
  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);

    if (res['success']) {
      List<Station> stations = List<Station>();
      List<dynamic> stationsInJson = res['result']['records'];
      stationsInJson.forEach((station) {
        print(station['SiteName']);
        print(station['County']);
        stations.add(Station.fromJson(station));
      });

      return stations;
    } else {
      return null;
    }
  } else {
    print('status code:${response.statusCode}');
    throw Exception('Failed to load data');
  }
}
