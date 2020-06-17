import 'dart:io';

import 'package:e_office/simpel/simpel_detail_surat_masuk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SimpelBukaSurat extends StatefulWidget {
 final String surat_link;
 final String surat_name;
 final String pathPDF;
  SimpelBukaSurat(String this.surat_link, String this.surat_name, String this.pathPDF);



  

  @override
  _SimpelBukaSuratState createState() => _SimpelBukaSuratState(surat_link, surat_name, pathPDF);
}

class _SimpelBukaSuratState extends State<SimpelBukaSurat> {

  SharedPreferences pref;
  String surat_link;
  String surat_name;
  
  bool _isLoading = true;
  PDFDocument document;

  String _version = 'Unknown';

  String localPath;
  String pathPDF = "";

  _SimpelBukaSuratState(this.surat_link, this.surat_name, this.pathPDF);

  _loadPdf() async{
    
     var dir = await getExternalStorageDirectory();
     File file  = File("${dir.path}/"+surat_name);
    document = await PDFDocument.fromFile(file);
    setState(() {
      _isLoading = false;
    });
  }
  _loadPdfURL() async{
    
     
    document = await PDFDocument.fromURL("https://simpel.pasamanbaratkab.go.id/upload/letter/mail/esign_surat%20permintaan%20aplikasi%20OPD-111.pdf");
    setState(() {
      _isLoading = false;
    });
  }

  

@override
  void initState() {
    // TODO: implement initState
   //_loadPdf();
   
    // initPlatformState();
    // PdftronFlutter.openDocument(surat_link);

    
    // super.initState();
    // loadPDF().then((value) {
    //   setState(() {
    //     localPath = value;
    //   });
    // });

    // print(localPath);

     
  }

// Future<void> initPlatformState() async {
//     String version;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       PdftronFlutter.initialize;
//       version = await PdftronFlutter.version;
//     } on PlatformException {
//       version = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _version = version;
//     });
//   }

  Future<String> loadPDF() async {
    //var response = await http.get(surat_link);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/"+surat_name);
    //file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text("Isi Surat"),),
    //   body: Center(
    //     child: _isLoading
    //         ? Center(child: CircularProgressIndicator())
    //         : PDFViewer(document: document, showPicker: false,)),

    //   // body: localPath != null
    //   //     ? PDFView(
    //   //         filePath: localPath,
    //   //       )
    //   //     : Center(child: CircularProgressIndicator()),
            
    //     //     body: Center(
    //     //   child: Text('Running on: $_version\n'),
    //     // ),
    
    // );

    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  
  }
}