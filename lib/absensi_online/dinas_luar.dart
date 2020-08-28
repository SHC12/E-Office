import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DinasLuar extends StatefulWidget {
  @override
  _DinasLuarState createState() => _DinasLuarState();
}

class _DinasLuarState extends State<DinasLuar> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File _file;
  SharedPreferences pref;

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'en_En';

    super.initState();
  }

  Future getFile() async {
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'png']);

    setState(() {
      _file = file;
    });
  }

  batchInsert(filePath2) {
    selectedDates.forEach((element) {
      print("tanggal : $element");
    });
  }

  void _uploadFile(filePath) {
    selectedDates.forEach((element) async {
      pref = await SharedPreferences.getInstance();
      String u = pref.getString('username');
      String iu = pref.getString('id_user');
      String nl = pref.getString('nama_lengkap');
      String ii = pref.getString('id_instansi');
      String id_admin_instansi = pref.getString('id_admin_instansi');
      String fileName = basename(filePath.path);
      print("file base name:$fileName");

      try {
        FormData formData = new FormData.fromMap({
          "id_user": iu.toString(),
          "id_admin_instansi": id_admin_instansi.toString(),
          "username": u.toString(),
          "nama_lengkap": nl.toString(),
          "instansi": ii.toString(),
          "tanggal": element,
          "spt_file":
              await MultipartFile.fromFile(filePath.path, filename: fileName),
        });

        Response response = await Dio().post(
            "https://mobileabsensi.pasamanbaratkab.go.id/api_android/post_dinas_luar.php",
            data: formData);
        print("File upload response: $response");
        _showSnackBarMsg(response.data['message']);
      } catch (e) {
        print("expectation Caugch: $e");
      }
    });
  }

  void _showSnackBarMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Formulir Dinas Luar"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Silahkan upload SPT dalam bentuk pdf atau gambar',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50.0,
                  child: GestureDetector(
                    onTap: () {
                      getFile();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "PILIH SPT",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SomeCalendar(
                      mode: SomeMode.Range,
                      labels: new Labels(
                        dialogDone: 'Kirim',
                        dialogCancel: 'Batal',
                        dialogRangeFirstDate: 'Berangkat Tanggal',
                        dialogRangeLastDate: 'Kembali Tanggal',
                      ),
                      primaryColor: Color(0xff5833A5),
                      startDate: Jiffy().subtract(years: 3),
                      lastDate: Jiffy().add(months: 9),
                      selectedDates: selectedDates,
                      isWithoutDialog: false,
                      done: (date) {
                        setState(() {
                          _uploadFile(_file);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
  }
}
