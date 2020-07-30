import 'package:e_office/animations/fadeanimations.dart';
import 'package:e_office/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopWidget extends StatefulWidget {
  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  SharedPreferences sharedPreferences;
  String nama_lengkap;
  String nama_jabatan;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      nama_lengkap = sharedPreferences.getString('nama_lengkap') ?? 'Nama user';
      nama_jabatan =
          sharedPreferences.getString('nama_instansi') ?? 'Nama Jabatan';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                1,
                Expanded(
                  child: Text(
                    'Halo! ' + nama_lengkap,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              FadeAnimation(
                1,
                Text(
                  nama_jabatan,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
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
              ),
              SizedBox(width: 12),
              FadeAnimation(
                1,
                GestureDetector(
                  onTap: () {
                    sharedPreferences.clear();
                    sharedPreferences.commit();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Icon(
                    FontAwesomeIcons.signOutAlt,
                    size: 24,
                    color: Colors.blueGrey,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
