import 'dart:convert';

import 'package:e_office/simpel/simpel_detail_surat_masuk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() => runApp(SimpelSuratMasuk());

class SimpelSuratMasuk extends StatefulWidget {
  @override
  _SimpelSuratMasukState createState() => _SimpelSuratMasukState();
}

class _SimpelSuratMasukState extends State<SimpelSuratMasuk> {
  SharedPreferences pref;
  String id_groups, id_instansi, id_user;

  dataAkun() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      id_user = pref.getString('id_user') ?? '0'; 
      id_groups = pref.getString('id_groups') ?? '0';
      id_instansi = pref.getString('id_instansi') ?? '0';
    });
  }

  Future<List<ModelSuratMasuk>> _getDataSuratMasuk() async {
    String URL =
        "http://simpel.pasamanbaratkab.go.id/api_android/simaya/model_surat_masuk_new.php?id_user=";
    String URL_LENGKAP;

    URL_LENGKAP = URL + id_user;

    var data = await http.get(URL_LENGKAP);

    var jsonData = json.decode(data.body);

    List<ModelSuratMasuk> surat_masuk = [];

    for (var u in jsonData) {
      ModelSuratMasuk modelSuratMasuk = ModelSuratMasuk(
          u["no"],
          u["token_surat"],
          u["id_surat"],
          u["no_surat_manual"],
          u["nama_naskah"],
          u["nama_pengirim"],
          u["perihal_surat"],
          u["status_penerima"],
          u["tgl_surat_manual"],
          u["tgl_surat"],
          u["surat_link"],
          u["surat_name"],
          u["surat_title"]);

      surat_masuk.add(modelSuratMasuk);
    }

    print(surat_masuk.length);

    return surat_masuk;
  }

  List<ModelSuratMasuk> model_surat_masuk;

  @override
  void initState() {
    super.initState();
    dataAkun();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getDataSuratMasuk(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              // return Container(child: Center(child: Text("Loading...")));
              return Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blueGrey,
                  size: 50.0,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data.length > 1) {
                    return new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          //Fluttertoast.showToast(msg: "token surat" + snapshot.data[index].token_surat);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SimpelDetailSuratMasuk(
                                  
                                  snapshot.data[index].token_surat,
                                  snapshot.data[index].perihal_surat,
                                  snapshot.data[index].tgl_surat_masuk,
                                  snapshot.data[index].tgl_surat,
                                  snapshot.data[index].no_surat_manual,
                                  snapshot.data[index].nama_naskah,
                                  snapshot.data[index].nama_pengirim,
                                  snapshot.data[index].id_surat,
                                  snapshot.data[index].surat_link,
                                  snapshot.data[index].surat_name,
                                  snapshot.data[index].surat_title),
                            ),
                          );
                        },
                        child: new Card(
                            elevation: 10,
                            child: new Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.toptal.com/designers/subtlepatterns/patterns/memphis-mini.png"),
                                    fit: BoxFit.cover),
                              ),
                              padding: new EdgeInsets.all(10.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    snapshot.data[index].nama_pengirim,
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(
                                        bottom: 20.0, top: 10.0),
                                    child: Text(
                                      snapshot.data[index].perihal_surat,
                                      style: new TextStyle(fontSize: 10.0),
                                    ),
                                  ),
                                  new Text(
                                    snapshot.data[index].status_penerima,
                                    style:
                                        snapshot.data[index].status_penerima ==
                                                'Sudah Dibaca'
                                            ? new TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.green)
                                            : new TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.red),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.all(50.0),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Card(
                            elevation: 10,
                            child: Stack(
                              children: <Widget>[
                                Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(4)
                                        //image: DecorationImage(image: AssetImage("assets/pattern.jpg"))

                                        ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Anda Tidak Memiliki Surat Masuk",
                                    style: TextStyle(
                                        color: Color(0xFFF56D5D), fontSize: 25),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  /*  return ListTile(
                      title: Text(snapshot.data[index].nama_pengirim, style: new TextStyle(color: Colors.blue),),
                      subtitle: Text(snapshot.data[index].perihal_surat),
                      onTap: (){
                      
                      },
                    );*/
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ModelSuratMasuk {
  final int no;
  final String token_surat;
  final String id_surat;
  final String no_surat_manual;
  final String nama_naskah;
  final String nama_pengirim;
  final String perihal_surat;
  final String status_penerima;
  final String tgl_surat_masuk;
  final String tgl_surat;
  final String surat_link;
  final String surat_name;
  final String surat_title;

  ModelSuratMasuk(
      this.no,
      this.token_surat,
      this.id_surat,
      this.no_surat_manual,
      this.nama_naskah,
      this.nama_pengirim,
      this.perihal_surat,
      this.status_penerima,
      this.tgl_surat_masuk,
      this.tgl_surat,
      this.surat_link,
      this.surat_name,
      this.surat_title);
}
