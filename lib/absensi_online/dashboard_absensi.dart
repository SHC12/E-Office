import 'package:e_office/absensi_online/kehadiran.dart';
import 'package:flutter/material.dart';

class DashboardAbsensi extends StatefulWidget {
  @override
  _DashboardAbsensiState createState() => _DashboardAbsensiState();
}

class _DashboardAbsensiState extends State<DashboardAbsensi> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Container(
          height: 600,
          width: double.infinity,
          child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  bottom: PreferredSize(
                      child: Container(
                        color: Colors.transparent,
                        child: SafeArea(
                            child: Column(
                          children: <Widget>[
                            TabBar(
                                indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        color: Color(0xffff0863), width: 4.0),
                                    insets: EdgeInsets.fromLTRB(
                                        40.0, 20.0, 40.0, 0)),
                                indicatorWeight: 15,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Color(0xff2d386b),
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w500),
                                unselectedLabelColor: Colors.black26,
                                tabs: [
                                  Tab(
                                    text: "KEHADIRAN",
                                    icon: Icon(Icons.perm_contact_calendar,
                                        size: 40),
                                  ),
                                  Tab(
                                    text: "RIWAYAT",
                                    icon: Icon(Icons.history, size: 40),
                                  ),
                                ])
                          ],
                        )),
                      ),
                      preferredSize: Size.fromHeight(55)),
                ),
                body: TabBarView(children: <Widget>[
                  Center(
                      child: KehadiranTab(),
                    ),
                    Center(
                      child: KehadiranTab(),
                    ),
                ]),
              )),
        ));
  }
}
