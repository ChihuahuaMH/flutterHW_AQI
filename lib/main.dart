import 'dart:ffi';

import 'package:aqi_1410732003/aqi_service.dart';
import 'package:aqi_1410732003/station.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('～ AQI 查詢 ～'),
          backgroundColor: Colors.teal[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AQIList(),
    );
  }
}

class AQIList extends StatefulWidget {
  @override
  _AQIListState createState() => _AQIListState();
}

class _AQIListState extends State<AQIList> {
  Future<List<Station>> futureStationList;

  @override
  void initState() {
    super.initState();
    futureStationList = fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Station>>(
          future: futureStationList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  MaterialColor AQIColor;
                  IconData AQIIcon;
                  if (snapshot.data[index].aqi <= 50) {
                    AQIColor = Colors.green;
                    AQIIcon = Icons.mood;
                  } else if (snapshot.data[index].aqi <= 100) {
                    AQIColor = Colors.yellow;
                    AQIIcon = Icons.mood;
                  } else if (snapshot.data[index].aqi <= 150) {
                    AQIColor = Colors.orange;
                    AQIIcon = Icons.mood_bad;
                  } else if (snapshot.data[index].aqi <= 200) {
                    AQIColor = Colors.red;
                    AQIIcon = Icons.mood_bad;
                  } else if (snapshot.data[index].aqi <= 300) {
                    AQIColor = Colors.purple;
                    AQIIcon = Icons.mood_bad;
                  } else {
                    AQIColor = Colors.brown;
                    AQIIcon = Icons.mood_bad;
                  }

                  return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: ListTile(
                      leading: Icon(
                        AQIIcon,
                        color: AQIColor,
                        size: 36,
                      ),
                      title: Text(
                        snapshot.data[index].siteName,
                        style: TextStyle(fontSize: 24, color: Colors.teal[700]),
                      ),
                      subtitle: Text(snapshot.data[index].county),
                      trailing: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AQIColor,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(
                                width: 1.5,
                                color: AQIColor,
                                style: BorderStyle.solid)),
                        child: Center(
                            child: Text(snapshot.data[index].aqi.toString(),
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AQIPage(snapshot.data[index])));
                        print('$index');
                      },
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else {}

            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 10,
              backgroundColor: Colors.teal[100],
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
            ));
          }),
    );
  }
}

class AQIPage extends StatelessWidget {
  Station station;
  AQIPage(this.station) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("詳細資訊"),
          backgroundColor: Colors.teal[200],
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" ${station.county}",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.explore,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" ${station.siteName}觀測站",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.mood,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" 狀態 ：${station.status}",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.mood_bad,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" 污染 ：${station.pollutant}",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" AQI ：${station.aqi}",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 36,
                      color: Colors.teal,
                    ),
                    Text(" PM2.5 ：${station.pm25}",
                        style: TextStyle(fontSize: 24, color: Colors.teal[700])),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
