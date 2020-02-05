import 'package:e_office/home.dart';
import 'package:e_office/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('username');   
  
  print(email);
  runApp(
    MaterialApp(home: email == null ? LoginPage() : HomePage()));
}
