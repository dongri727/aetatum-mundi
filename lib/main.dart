import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cover_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aetatum Mundi',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2f4f4f),
        brightness: Brightness.dark,
        //primaryColor: Colors.indigo,
      ),
      home: const CoverPage(),
    );
  }
}