import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:e_office/absensi_online/clock/clock.dart';
import 'package:e_office/style.dart';
import 'package:e_office/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

class KehadiranTab extends StatefulWidget {
  @override
  _KehadiranTabState createState() => _KehadiranTabState();
}

class _KehadiranTabState extends State<KehadiranTab> {
  String _timeString;
  Timer timer;

  String absen_masuk = "";
  String absen_pulang = "";
  String datetime;
  DateTime now;
  String wifiName, wifiBSSID, wifiIP;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState

    _timeString = _formatDateTime(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    timer.cancel();
    super.dispose();
    _connectivitySubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  // void getAbsenMasuk() async{

  //     Response response = await get('http://worldtimeapi.org/api/timezone/Asia/Jakarta');
  //     Map data = jsonDecode(response.body);

  //     String datetime = data['datetime'];
  //     String offset = data['utc_offset'].substring(1,3);

  //     DateTime now = DateTime.parse(datetime).toLocal();

  //     setState(() {
  //       absen_masuk = now.toString();
  //     });

  //     print(now);
  // }
  void getAbsenMasuk() async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);

    if (wifiName == 'ppp') {
      setState(() {
        absen_masuk = formattedTime;
      });
    } else {
      setState(() {
        print("gagal");
      });
    }
  }

  void getAbsenPulang() async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);

    setState(() {
      absen_pulang = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Padding(
            //padding: EdgeInsets.symmetric(horizontal: 60),
            padding: Sizes.spacingClock,
            child: Clock(),
          ),
          SizedBox(height: Sizes.s20),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _timeString,
                  style: TextStyle(
                      color: Color(0xff2d386b),
                      fontSize: Sizes.s25,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Sizes.s20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ABSEN MASUK",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: Sizes.s12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3),
                  ),
                  SizedBox(
                    height: Sizes.s10,
                  ),
                  absen_masuk == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: Sizes.s20),
                              padding: EdgeInsets.all(Sizes.s20),
                              child: GestureDetector(
                                onTap: () {
                                  getAbsenMasuk();
                                },
                                child: Center(
                                  child: Icon(FontAwesomeIcons.fingerprint,
                                      size: Sizes.s25, color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: tealGradient,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          absen_masuk,
                          style: TextStyle(
                              color: Color(0xff2d386b),
                              fontSize: Sizes.s30,
                              fontWeight: FontWeight.w700),
                        )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ABSEN PULANG",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: Sizes.s12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3),
                  ),
                  SizedBox(
                    height: Sizes.s10,
                  ),
                  absen_pulang == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: Sizes.s20),
                              padding: EdgeInsets.all(Sizes.s20),
                              child: GestureDetector(
                                onTap: () {
                                  getAbsenPulang();
                                },
                                child: Center(
                                  child: Icon(FontAwesomeIcons.fingerprint,
                                      size: Sizes.s25, color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: darkRedGradient,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          absen_pulang,
                          style: TextStyle(
                              color: Color(0xff2d386b),
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Sizes.s30,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Sizes.s50, 0, Sizes.s50, Sizes.s10),
            child: FlatButton(
              child: Text(
                "Dinas Luar",
                style: TextStyle(letterSpacing: 1.5),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Sizes.s50, 0, Sizes.s50, Sizes.s10),
            child: FlatButton(
              child: Text(
                "Ijin",
                style: TextStyle(letterSpacing: 1.5),
              ),
              color: Colors.lightGreen,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {},
            ),
          ),
          Text('Connection Status: $_connectionStatus'),
        ],
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d/M/yyyy \n HH:mm:ss').format(dateTime);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
