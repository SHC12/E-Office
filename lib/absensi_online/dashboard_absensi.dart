import 'package:e_office/absensi_online/kehadiran.dart';
import 'package:e_office/util/size.dart';
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
                                        color: Colors.blue, width: 4.0),
                                    insets: EdgeInsets.fromLTRB(
                                        Sizes.s40, Sizes.s20, Sizes.s40, 0)),
                                indicatorWeight: Sizes.s25,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Color(0xff2d386b),
                                labelStyle: TextStyle(
                                    fontSize: Sizes.s15,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w500),
                                unselectedLabelColor: Colors.black26,
                                tabs: [
                                  Tab(
                                    text: "KEHADIRAN",
                                    icon: Icon(Icons.perm_contact_calendar,
                                        size: Sizes.s30),
                                  ),
                                  Tab(
                                    text: "RIWAYAT",
                                    icon: Icon(Icons.history, size: Sizes.s30),
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
