import 'package:e_office/absensi_online/dashboard_absensi.dart';
import 'package:e_office/animations/fadeanimations.dart';
import 'package:e_office/simpel/simpel_dashboard.dart';
import 'package:e_office/style.dart';
import 'package:e_office/top.dart';
import 'package:flutter/material.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
              GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme)),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFEFEFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 54, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           TopWidget(),
            SizedBox(height: 24),
            _title('Aplikasi'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _simpelCard('SiMPEL', 'assets/simpel.jpg'),
                _absensiCard('Absensi Online', 'assets/image_02.png'),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _promotionCard('Tanda Tangan Digital', 'assets/image_01.png'),
                _promotionCard('SITUKIN', 'assets/image_01.png'),
              ],
            ),
            SizedBox(height: 12),
            _title('Buku Panduan Aplikasi'),
          ],
        ),
      ),
    );
  }

  _promotionCard(String title, String assetUrl) {
    return FadeAnimation(
      1,
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width / 2 - 30,
            decoration: BoxDecoration(
                color: Color(0XFFDDFF3FF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ]),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(assetUrl, height: 80, fit: BoxFit.fitHeight),
              
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  _simpelCard(String title, String assetUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardSimpel()));
      },
      child: FadeAnimation(
        1,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width / 2 - 30,
              decoration: BoxDecoration(
                  color: Color(0XFFDDFF3FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ]),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(assetUrl, height: 80, fit: BoxFit.fitHeight),
            
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _absensiCard(String title, String assetUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardAbsensi()));
      },
      child: FadeAnimation(
        1,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width / 2 - 30,
              decoration: BoxDecoration(
                  color: Color(0XFFDDFF3FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ]),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(assetUrl, height: 80, fit: BoxFit.fitHeight),
            
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _greetings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FadeAnimation(
          1,
          Text(
            'Selamat Datang',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        FadeAnimation(
          1,
          Text(
            'Nama Jabatan',
            style: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  _trailingIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FadeAnimation(
          1,
          Icon(
            FontAwesomeIcons.bell,
            size: 24,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  _title(String title) {
    return FadeAnimation(
      1,
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey[900],
        ),
      ),
    );
  }

  _menuItem(String title, IconData iconData, LinearGradient gradient) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.35,
      width: MediaQuery.of(context).size.width * 0.26,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Icon(iconData, size: 24, color: Colors.white),
            ),
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
