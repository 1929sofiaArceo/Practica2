import 'package:firebase_core/firebase_core.dart';
import 'package:sof/login.dart';
import './home_page.dart';
import 'package:flutter/material.dart';
import './proveedor.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Proveedor>(create: (context) => Proveedor()),
          // Provider<SomethingElse>(create: (_) => SomethingElse()),
          // Provider<AnotherThing>(create: (_) => AnotherThing()),
        ],
        child: HomePage(),
      )
    );
  }
}
