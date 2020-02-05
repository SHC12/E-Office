import 'package:e_office/simpel/simpel_detail_surat_masuk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SimpelBukaSurat extends StatefulWidget {
 final String surat_link;
  SimpelBukaSurat(String this.surat_link);

  


  

  @override
  _SimpelBukaSuratState createState() => _SimpelBukaSuratState(surat_link);
}

class _SimpelBukaSuratState extends State<SimpelBukaSurat> {

  SharedPreferences pref;
  String surat_link;
  bool _isLoading = true;
  PDFDocument document;

  _SimpelBukaSuratState(this.surat_link);

  _loadPdf() async{
    document = await PDFDocument.fromURL(surat_link);
    setState(() {
      _isLoading = false;
    });
  }

@override
  void initState() {
    // TODO: implement initState
    _loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Isi Surat"),),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(document: document, showPicker: true,)),
            
    
    );
  }
}