import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as http_dio;
import 'package:e_office/top.dart';
import 'package:e_office/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardAdminAbsensi extends StatefulWidget {
  @override
  _DashboardAdminAbsensiState createState() => _DashboardAdminAbsensiState();
}

class _DashboardAdminAbsensiState extends State<DashboardAdminAbsensi> {
  String wifiName, wifiBSSID, wifiIP;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  SharedPreferences pref;

  String id_instansi;
  String username;
  String nama_instansi;
  String nama_wifi;
  String bssid;
  String ip_address;

  String getSSID;
  String getBSSID;
  String getIP;

  String url_validasi =
      "http://mobileabsensi.pasamanbaratkab.go.id/api_android/validasi_absen.php?username_admin=";
  String url_lengkap;

  dataAkun() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      id_instansi = pref.getString('id_instansi') ?? '0';
      nama_instansi = pref.getString('nama_instansi') ?? '0';
      username = pref.getString('username') ?? '0';
    });
  }

  getWifiTerdaftar() async {
    pref = await SharedPreferences.getInstance();
    String ua = pref.getString('username');
    url_lengkap = url_validasi + ua;
    var jsonResponse = null;

    var response = await http.get(url_lengkap);

    jsonResponse = json.decode(response.body);
    if (jsonResponse != null) {
      setState(() {
        var data = jsonResponse[0];
        nama_wifi = data['SSID'];
        bssid = data['BSSID'];
        ip_address = data['IP_ADD'];
      });

      print("SSID" +
          nama_wifi.toString() +
          "\n BSSID" +
          ip_address.toString() +
          "\n username " +
          username);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAkun();
    //getDataWifi();
    getWifiTerdaftar();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _connectivitySubscription.cancel();
  }

  // Future getDataWifi() async {
  //   pref = await SharedPreferences.getInstance();
  //   http_dio.Response response;
  //   http_dio.Dio dio = new http_dio.Dio();
  //   String ua = pref.getString('username');

  //   response = await dio.get(
  //       "https://mobileabsensi.pasamanbaratkab.go.id/api_android/validasi_absen.php?username_admin=" +
  //           ua.toString());

  //   final rawData = jsonDecode(jsonEncode(response.data));
  //   var getData = rawData[0];
  //   nama_wifi = getData['SSID'];
  //   bssid = getData['BSSID'];
  //   ip_address = getData['IP_ADD'];

  //   print("SSID" +
  //       nama_wifi.toString() +
  //       "\n BSSID" +
  //       ip_address.toString() +
  //       "\n username " +
  //       username);
  // }

  scanWifi(String ssidWifi, String bssidWifi, String ip_add) async {
    Map data = {
      'id_instansi': id_instansi,
      'SSID': ssidWifi,
      'BSSID': bssidWifi,
      'username_admin': username,
      'nama_opd': nama_instansi,
      'ip_add': ip_add
    };
    var jsonResponse = null;
    var response = await http.post(
        "https://mobileabsensi.pasamanbaratkab.go.id/api_android/insert_data_wifi.php",
        body: data);

    jsonResponse = json.decode(response.body);

    setState(() {
      if (jsonResponse != null) {
        int success = jsonResponse['code'];

        if (success == 1) {
          print('BERHASIL SCAN WIFI');
        }
      } else {
        print(response.body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(wifiBSSID);
    print(wifiIP);
    print(wifiName);

    return Scaffold(
      backgroundColor: Color(0XFFFEFEFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 54, right: 16),
        child: Column(
          children: <Widget>[
            TopWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Text(
              "INFORMASI WIFI YANG TERHUBUNG",
              style: TextStyle(fontSize: 22, color: Colors.lightBlue),
            ),
            new Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Nama Wifi : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            wifiName,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "BSSID : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            wifiBSSID,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "IP Address : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            wifiIP,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Text(
              "INFORMASI WIFI YANG DIDAFTARKAN",
              style: TextStyle(fontSize: 22, color: Colors.lightBlue),
            ),
            new Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Nama Wifi : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            nama_wifi.toString(),
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "BSSID : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            bssid.toString(),
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "IP Address : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                              child: Text(
                            ip_address.toString(),
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            SizedBox(
              height: Sizes.s30,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Sizes.s50, 0, Sizes.s50, Sizes.s10),
              child: FlatButton(
                child: Text(
                  "Scan Wifi Absensi",
                  style: TextStyle(letterSpacing: 1.5),
                ),
                color: Colors.blueAccent,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  scanWifi(wifiName, wifiBSSID, wifiIP);
                },
              ),
            ),
          ],
        ),
      ),
    );
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
