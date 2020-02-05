import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PdfSuratMasuk {
  String id_surat_pdf;
  String surat_name;
  String surat_link;

  PdfSuratMasuk({this.id_surat_pdf, this.surat_name, this.surat_link});

  factory PdfSuratMasuk.createPdf(Map<String, dynamic> object) {
    return PdfSuratMasuk(
        id_surat_pdf: object['id_surat'],
        surat_name: object['surat_name'],
        surat_link: object['surat_link']);
  }

  static Future<PdfSuratMasuk> connectToAPI(String id_surat_api) async {
    String apiURL =
        "https://simpel.pasamanbaratkab.go.id/api_android/simaya/get_file_pdf_disposisi_masuk.php?id_surat=" +
            id_surat_api;

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
 
    var pdfData = (jsonObject as Map<String, dynamic>)['response'];

    print(pdfData);
    return PdfSuratMasuk.createPdf(pdfData);
  }
}
