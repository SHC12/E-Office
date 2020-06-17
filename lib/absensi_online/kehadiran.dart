import 'package:e_office/absensi_online/clock/clock.dart';
import 'package:flutter/material.dart';

class KehadiranTab extends StatefulWidget {
  @override
  _KehadiranTabState createState() => _KehadiranTabState();
}

class _KehadiranTabState extends State<KehadiranTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Clock(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
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
                      color: Color(0xffff0863),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "06:12 PM",
                    style: TextStyle(
                      color: Color(0xff2d386b),
                      fontSize: 30,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ABSEN PULANG",
                    style: TextStyle(
                      color: Color(0xffff0863),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "08:00 AM",
                    style: TextStyle(
                      color: Color(0xff2d386b),
                      fontSize: 30,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),


          ],
        )
      ],
    );
  }
}