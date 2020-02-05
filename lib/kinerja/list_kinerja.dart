import 'dart:convert';
import 'package:e_office/kinerja/buat_kinerja.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


void main() => runApp(ListKinerja());

class ListKinerja extends StatefulWidget {
  @override
  _ListKinerjaState createState() => _ListKinerjaState();
}

class _ListKinerjaState extends State<ListKinerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: Text("Daftar Kinerja"),
   ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.ac_unit ),
            label: "Buat Kinerja Baru",
            onTap: (){
                 Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BuatKinerja();
                    }));
 
            }

          ),
         
        ],
      ),
    );
  }
}