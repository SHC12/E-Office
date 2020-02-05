import 'package:e_office/kinerja/list_kinerja.dart';
import 'package:e_office/login_page.dart';
import 'package:e_office/simpel/simpel_surat_masuk.dart';
import 'package:e_office/wardes/list_wardes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'E-Office Pasaman Barat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  SharedPreferences sharedPreferences;
  String message = '';

  

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      message = sharedPreferences.getString('message') ?? 'Hi, User';
    });
    if (sharedPreferences.getString("username") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _top(),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Aplikasi Surat Menyurat",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 250.0,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 3 / 2),
              children: <Widget>[
                _gridItemSuratMasuk(Icons.inbox),
                _gridItemDisposisiMasuk(Icons.assignment_returned),
                _gridItemTembusan(Icons.closed_caption),
                _gridItemSuratKeluar(Icons.publish),
                _gridItemDisposisiKeluar(Icons.assignment_return),
                _gridItemKonsep(Icons.attachment),
                _gridDummy(),
                _gridItemTandaTangan(Icons.gesture),
                
                

               
                

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Aplikasi Kinerja",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 100.0,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 3 / 2),
              children: <Widget>[
                _gridItemAbsensiOnline(Icons.timeline),
                _gridItemSPPDOnline(Icons.transform),
                _gridItemSAPK(Icons.note_add),
                _gridItemWardes(Icons.note),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _gridDummy() {
    return Column(
     
    );
  }

  _gridItemSuratMasuk(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SimpelSuratMasuk();
                    }));
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Surat Masuk",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
  _gridItemDisposisiMasuk(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
           
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Disposisi Masuk",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
  _gridItemTembusan(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
           
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Tembusan",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

  _gridItemSuratKeluar(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
             /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SimpelSuratKeluar();
                    }));*/
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Surat Keluar",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
  _gridItemDisposisiKeluar(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
           
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Disposisi Keluar",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
  _gridItemKonsep(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
           
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Konsep",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

   _gridItemTandaTangan(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
           
          },
          child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Tanda Tangan",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
  

  _gridItemAbsensiOnline(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
                  child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Absensi Online",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

  _gridItemSPPDOnline(icon) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            icon,
            size: 16.0,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlue.withOpacity(0.9),
        ),
        SizedBox(height: 10.0),
        Text(
          "SPPD Online",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

   _gridItemWardes(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
             Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListWardes();
                    }));
          },
                  child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Wartawan Desa",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

  _gridItemSAPK(icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
             Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListKinerja();
                    }));
          },
                  child: CircleAvatar(
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "SAPK",
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }

  _top() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.only(  
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () {
                  sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
