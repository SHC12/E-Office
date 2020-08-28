import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:device_info/device_info.dart';
import 'package:e_office/absensi_online/clock/clock.dart';
import 'package:e_office/absensi_online/clock/ijin.dart';
import 'package:e_office/absensi_online/dinas_luar.dart';
import 'package:e_office/style.dart';
import 'package:e_office/util/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KehadiranTab extends StatefulWidget {
  @override
  _KehadiranTabState createState() => _KehadiranTabState();
}

class _KehadiranTabState extends State<KehadiranTab> {
  bool _visible = true;

  String _timeString, _timeStringSql;
  Timer timer;

  String id_groups, id_kategori, id_user, id_admin_instansi, username;

  String absen_masuk = "";
  String absen_pulang = "";
  String status_absen = "";
  String datetime;
  DateTime now;
  String wifiName, wifiBSSID, wifiIP, wifiSSID;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var a = Connectivity().getWifiIP();
  String rSSID, rBSSID, rIP_ADD;

  String id_instansi;
  String nama_lengkap;
  String username_admin;
  String jam_masuk;

  String nama_wifi;
  String bssid;
  String ip_address;

  String formattedTime;

  String id_user_validasi_device;
  String username_validasi_device;

  ProgressDialog pr;
  SharedPreferences pref;

  String url_validasi =
      "http://mobileabsensi.pasamanbaratkab.go.id/api_android/validasi_absen.php?username_admin=";
  String url_lengkap;

  String url_validasi_device =
      "https://mobileabsensi.pasamanbaratkab.go.id/api_android/get_validasi_device.php?device_id=";
  String device_id;
  String url_lengkap_validasi_device;

  String url_jam_masuk =
      "http://mobileabsensi.pasamanbaratkab.go.id/api_android/get_jam_masuk.php?username=";
  String url_lengkap_jam_masuk;

  String url_jam_pulang =
      "http://mobileabsensi.pasamanbaratkab.go.id/api_android/get_jam_pulang.php?username=";
  String url_lengkap_jam_pulang;

  Uri apiUrl = Uri.parse(
      'https://mobileabsensi.pasamanbaratkab.go.id/api_android/insert_absen_masuk.php');
  Uri apiUrlAbsenPulang = Uri.parse(
      'https://mobileabsensi.pasamanbaratkab.go.id/api_android/post_absen_pulang.php');

  Uri apiUrlAbsenmasuk = Uri.parse(
      'https://mobileabsensi.pasamanbaratkab.go.id/api_android/post_absen_masuk.php');

  dataAkun() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      id_user = pref.getString('id_user') ?? '0';
      id_admin_instansi = pref.getString('id_admin_instansi') ?? '0';
      username = pref.getString('username') ?? '0';
      nama_lengkap = pref.getString('nama_lengkap') ?? '0';
      id_groups = pref.getString('id_groups') ?? '0';
      id_instansi = pref.getString('id_instansi') ?? '0';
      id_kategori = pref.getString('id_kategori') ?? '0';
      username_admin = pref.getString('username_admin') ?? '0';
    });
  }

  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    return androidDeviceInfo.androidId;
  }

  getValidasiDevice() async {
    url_lengkap_validasi_device = url_validasi_device + device_id;
    var jsonResponse = null;
    var response = await http.get(url_lengkap_validasi_device);

    jsonResponse = json.decode(response.body);
    if (jsonResponse != null) {
      setState(() {
        var data = jsonResponse[0];
        id_user_validasi_device = data['id_user_validasi'];
        username_validasi_device = data['username_validasi'];
      });

      print("id_user_validasi :  " +
          id_user_validasi_device.toString() +
          "\n username_validasi :  " +
          username.toString());
    }
  }

  getWifiTerdaftar() async {
    pref = await SharedPreferences.getInstance();
    String ua = pref.getString('username_admin');
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

      print("SSID" + nama_wifi.toString() + "\n BSSID" + ip_address.toString());
    }
  }

  getJamMasuk() async {
    pref = await SharedPreferences.getInstance();
    String u = pref.getString('username');
    url_lengkap_jam_masuk = url_jam_masuk + u;
    var jsonResponse = null;

    var response = await http.get(url_lengkap_jam_masuk);

    jsonResponse = json.decode(response.body);
    if (jsonResponse != null) {
      setState(() {
        var data = jsonResponse[0];

        if (data['waktu_masuk'] != null) {
          absen_masuk = data['waktu_masuk'];
        } else {
          absen_masuk = "";
        }

        if (data['status_absen'] != null) {
          status_absen = data['status_absen'];
        } else {
          status_absen = "";
        }
        print('jam_masuk : $absen_masuk');
      });
    } else {
      setState(() {
        absen_masuk = "";
      });
    }
  }

  getJamPulan() async {
    pref = await SharedPreferences.getInstance();
    String u = pref.getString('username');
    url_lengkap_jam_pulang = url_jam_pulang + u;
    var jsonResponse = null;

    var response = await http.get(url_lengkap_jam_pulang);

    jsonResponse = json.decode(response.body);
    if (jsonResponse != null) {
      setState(() {
        var data = jsonResponse[0];

        if (data['waktu_pulang'] != null) {
          absen_pulang = data['waktu_pulang'];
        } else {
          absen_pulang = "";
        }
      });
    } else {
      setState(() {
        absen_masuk = "";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    dataAkun();
    getWifiTerdaftar();
    getJamMasuk();
    getJamPulan();
    _getDeviceId().then((value) {
      setState(() {
        device_id = value;
        getValidasiDevice();
      });
    });
    _timeString = _formatDateTime(DateTime.now());
    _timeStringSql = _formatDateTimeSql(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    timer.cancel();

    _connectivitySubscription.cancel();
    super.dispose();
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

    // Check to see if Android Location permissions are enabled
    // Described in https://github.com/flutter/flutter/issues/51529
    if (Platform.isAndroid) {
      print('Checking Android permissions');
      var status = await Permission.location.status;
      // Blocked?
      if (status.isUndetermined || status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print('Location permission granted');
        } else {
          print('Location permission not granted');
        }
      } else {
        print('Permission already granted (previous execution?)');
      }
    }

    return _updateConnectionStatus(result);
  }

  Future<Map<String, dynamic>> _uploadDataAbsenMasuk() async {
    DateTime now = DateTime.now();
    formattedTime = DateFormat.Hm().format(now);
    setState(() {});

    final data = http.MultipartRequest('POST', apiUrlAbsenmasuk);

    data.fields['id_user'] = id_user;
    data.fields['username'] = username;
    data.fields['id_admin_instansi'] = id_admin_instansi;
    data.fields['nama_lengkap'] = nama_lengkap;
    data.fields['instansi'] = id_instansi;
    data.fields['SSID'] = rSSID;
    data.fields['BSSID'] = rBSSID;
    data.fields['ip_add'] = rIP_ADD;
    data.fields['jam_masuk'] = formattedTime;
    data.fields['tgl_absen'] = _timeStringSql;

    try {
      final streamedResponse = await data.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  // Future<Map<String, dynamic>> _uploadDataAbsenMasuk() async {
  //   DateTime now = DateTime.now();
  //   formattedTime = DateFormat.Hm().format(now);
  //   setState(() {});

  //   final data = http.MultipartRequest('POST', apiUrl);

  //   data.fields['id_user'] = id_user;
  //   data.fields['username'] = username;
  //   data.fields['jam_masuk'] = _timeStringSql;
  //   data.fields['id_instansi'] = id_instansi;
  //   data.fields['nama_lengkap'] = nama_lengkap;
  //   data.fields['SSID'] = rSSID;
  //   data.fields['BSSID'] = rBSSID;
  //   data.fields['waktu_jam_masuk'] = formattedTime;
  //   data.fields['ip_add'] = rIP_ADD;

  //   try {
  //     final streamedResponse = await data.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     String code = responseData['code'];
  //     if (code == 1) {
  //       _resetState();
  //       return responseData;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  Future<Map<String, dynamic>> _uploadDataAbsenPulang() async {
    DateTime now = DateTime.now();
    formattedTime = DateFormat.Hm().format(now);

    int hMasuk = int.parse(absen_masuk.split(":")[0]);
    int mMasuk = int.parse(absen_masuk.split(":")[1]);

    int hPulang = int.parse(formattedTime.split(":")[0]);
    int mPulang = int.parse(formattedTime.split(":")[1]);

    int totalHKerja = hMasuk - hPulang;
    int totalMKerja = mMasuk - mPulang;

    var dTotalKerja = Duration(hours: totalHKerja, minutes: totalMKerja);

    var meniTotalKerja = dTotalKerja.abs().inMinutes;

    final data = http.MultipartRequest('POST', apiUrlAbsenPulang);

    data.fields['jam_pulang'] = formattedTime;
    data.fields['waktu_kerja'] = meniTotalKerja.toString();

    try {
      final streamedResponse = await data.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      String code = responseData['code'];
      if (code == 1) {
        _resetState();
        return responseData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void getAbsenMasuk() async {
    pref = await SharedPreferences.getInstance();
    String id_user_am = pref.getString('id_user');
    String username_am = pref.getString('username');
    if (id_user_am == id_user_validasi_device) {
      if (status_absen == '2') {
        CoolAlert.show(
          context: context,
          title: "Info !",
          type: CoolAlertType.info,
          text:
              "Anda tidak bisa melakukan absen karena anda masih dalam status dinas luar !",
        );
      } else if (status_absen == '3') {
        CoolAlert.show(
          context: context,
          title: "Info !",
          type: CoolAlertType.info,
          text:
              "Anda tidak bisa melakukan absen karena anda masih dalam status ijin !",
        );
      } else {
        if (rSSID == nama_wifi && rBSSID == bssid) {
          final Map<String, dynamic> response = await _uploadDataAbsenMasuk();

          if (response == null) {
            setState(() {
              CoolAlert.show(
                context: context,
                title: "Sukses !",
                type: CoolAlertType.success,
                text: "Anda telah berhasil melakukan absen masuk !",
              );
              absen_masuk = formattedTime;
              print("sukses");
            });
          } else {
            print("gagal");
          }
          // DateTime now = DateTime.now();
          // formattedTime = DateFormat.Hm().format(now);

          // print('id_user : $id_user\n'
          //     'username : $username\n'
          //     'jam_masuk : $_timeStringSql\n'
          //     'id_instansi : $id_instansi\n'
          //     'SSID : $rSSID\n'
          //     'BSSID : $rBSSID\n'
          //     'IP_ADD : $rIP_ADD\n'
          //     'jam_masuk : $formattedTime\n'
          //     'nama_lengkap : $nama_lengkap\n');
        } else {
          CoolAlert.show(
            context: context,
            title: "Gagal !",
            type: CoolAlertType.error,
            text:
                "Silahkan terhubung dengan Wifi $nama_wifi agar dapat melakukan absen!",
          );
        }
      }
    } else {
      CoolAlert.show(
        context: context,
        title: "Gagal !",
        type: CoolAlertType.error,
        text:
            "Anda tidak dapat melakukan absen pada perangkat ini, silahkan hubungi admin instansi anda!",
      );
    }
  }

  void postAbsenPulang() async {
    if (rSSID == nama_wifi && rBSSID == bssid) {
      if (absen_masuk == null) {
        CoolAlert.show(
          context: context,
          title: "Info !",
          type: CoolAlertType.info,
          text: "Silahkan lakukan absen masuk terlebih dahulu !",
        );
      }
      final Map<String, dynamic> response = await _uploadDataAbsenPulang();

      if (response == null) {
        setState(() {
          CoolAlert.show(
            context: context,
            title: "Sukses !",
            type: CoolAlertType.success,
            text: "Anda telah berhasil melakukan absen pulang !",
          );
          absen_pulang = formattedTime;
          print("sukses");
        });
      } else {
        print("gagal");
      }
      // DateTime now = DateTime.now();
      // formattedTime = DateFormat.Hm().format(now);

      // print('id_user : $id_user\n'
      //     'username : $username\n'
      //     'jam_masuk : $_timeStringSql\n'
      //     'id_instansi : $id_instansi\n'
      //     'SSID : $rSSID\n'
      //     'BSSID : $rBSSID\n'
      //     'IP_ADD : $rIP_ADD\n'
      //     'jam_masuk : $formattedTime\n'
      //     'nama_lengkap : $nama_lengkap\n');
    } else {
      CoolAlert.show(
        context: context,
        title: "Gagal !",
        type: CoolAlertType.error,
        text:
            "Silahkan terhubung dengan Wifi $nama_wifi agar dapat melakukan absen!",
      );
    }
  }

  void _resetState() {
    setState(() {});
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
                                  if (absen_masuk == "") {
                                    CoolAlert.show(
                                      context: context,
                                      title: "Info !",
                                      type: CoolAlertType.info,
                                      text:
                                          "Silahkan melakukan absen masuk terlebih dahulu",
                                    );
                                  } else {
                                    postAbsenPulang();
                                  }
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DinasLuar()));
              },
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
              onPressed: () {
                Get.to(Ijin());
              },
            ),
          ),
          // Text('Connection Status: $_connectionStatus'),
        ],
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    final String formattedDateTimeSql = _formatDateTimeSql(now);
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
        _timeStringSql = formattedDateTimeSql;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d/M/yyyy \n HH:mm:ss').format(dateTime);
  }

  String _formatDateTimeSql(DateTime dateTime) {
    return DateFormat('yyyy-M-d HH:mm:ss').format(dateTime);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print('Result: $result');
    switch (result) {
      case ConnectivityResult.wifi:
        //String wifiName, wifiBSSID, wifiIP;
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
          print('Error: $e.toString()');
          wifiName = "Failed to get Wifi Name";
        }
        print('Wi-Fi Name: $wifiName');

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
        print('BSSID: $wifiBSSID');

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          // _connectionStatus = '$result\n'
          //     'Wifi Name: $wifiName\n'
          //     'Wifi BSSID: $wifiBSSID\n'
          //     'Wifi IP: $wifiIP\n';

          rSSID = wifiName;
          rBSSID = wifiBSSID;
          rIP_ADD = wifiIP;
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
