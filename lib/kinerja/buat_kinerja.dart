import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(BuatKinerja());

class BuatKinerja extends StatefulWidget {
  @override
  _BuatKinerjaState createState() => _BuatKinerjaState();
}

class _BuatKinerjaState extends State<BuatKinerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Buat Kinerja Baru"),                                                                                                                                                                                                                  
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
              child: new Container(
          padding: new EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                  hintText: "",
                  labelText: "Nama Kinerja",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
               new TextField(
                 maxLines: 3,
                decoration: new InputDecoration(
                  hintText: "",
                  labelText: "Dekripsi Kinerja",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
                new Padding(padding: new EdgeInsets.only(top: 20.0),),
               new TextField(
                 
                decoration: new InputDecoration(
                  hintText: "",
                  labelText: "Tanggal Dimulai",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
                new Padding(padding: new EdgeInsets.only(top: 20.0),),
               new TextField(
                 
                decoration: new InputDecoration(
                  hintText: "",
                  labelText: "Indikator Kinerja",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
