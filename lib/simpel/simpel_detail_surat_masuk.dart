import 'dart:convert';
import 'dart:io';

import 'package:e_office/model/Pdf_surat_masuk.dart';
import 'package:e_office/simpel/simpel_buka_surat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpelDetailSuratMasuk extends StatefulWidget {
  String id_surat;
  String nama_naskah;
  String nama_pengirim;
  String no_surat_manual;
  String token_surat;
  String perihal_surat;
  String tgl_surat_masuk;
  String tgl_surat;
  String surat_name;
  String surat_title;
  String surat_link;

  SimpelDetailSuratMasuk(
      this.token_surat,
      this.perihal_surat,
      this.tgl_surat_masuk,
      this.tgl_surat,
      this.no_surat_manual,
      this.nama_naskah,
      this.nama_pengirim,
      this.id_surat,
      this.surat_link,
      this.surat_name,
      this.surat_title);

  void getsurat_link() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("surat_link", surat_name);
  }

  @override
  _SimpelDetailSuratMasukState createState() =>
      _SimpelDetailSuratMasukState(surat_link, surat_name);
}

class _SimpelDetailSuratMasukState extends State<SimpelDetailSuratMasuk> {
  String a;

  //String surat_link2;

  String surat_link;
  String surat_name;
  String pathPDF = "";

  _SimpelDetailSuratMasukState(this.surat_link, this.surat_name);

  bool downloading = false;
  var progressString = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });

    //downloadFile();
    //download();
  }

Future<File> createFileOfPdfUrl() async {
    final url = surat_link;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
  Future<void> download() async{
    var dir = await getExternalStorageDirectory();

    Dio dio = new Dio();
    dio.download(surat_link, "${dir.path}/"+surat_name);

    print("Surat Link : " + surat_link + "\n Surat Name : " + surat_name + "\n dir : ${dir.path} ");
  }
  

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(surat_link, "${dir.path}/myimage.pdf",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi Surat Masuk"),
      ),
      body: new Container(
          child: downloading
              ? Container(
                  height: 120.0,
                  width: 200.0,
                  child: Center(
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Mohon Tunggu....",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : new Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Tanggal Surat : ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Flexible(
                                      child: Text(
                                    widget.tgl_surat,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Nama Pengirim : ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Flexible(
                                      child: Text(
                                    widget.nama_pengirim,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Perihal Surat : ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Flexible(
                                      child: Text(
                                    widget.perihal_surat,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Jenis Naskah : ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Flexible(
                                      child: Text(
                                    widget.nama_naskah,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    ),
                    Text(
                      "ISI SURAT",
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
                                    "Judul Surat : ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Flexible(
                                      child: Text(
                                    widget.surat_title,
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ))
                                ],
                              ),
                              RaisedButton(
                                child: Text(
                                  "Buka Surat",
                                ),
                                onPressed: () {
                                  // saveSurat(widget.surat_link);

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SimpelBukaSurat(widget.surat_link, widget.surat_name, pathPDF);
                                  }));
                                },
                              )
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    ),
                  ],
                )),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.ac_unit),
              label: "Buat Disposisi",
              onTap: () {}),
          SpeedDialChild(
              child: Icon(Icons.verified_user),
              label: "Verfikasi Tanda Tangan Elektronik",
              onTap: () {})
        ],
      ),
    );
  }

}

/*
saveSurat(String surat_link) async {
  //String link_surat;
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setString("surat_link", surat_link);
}*/
