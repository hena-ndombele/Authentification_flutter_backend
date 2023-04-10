import 'package:flutter/material.dart';
import 'package:flutter_fidele/controllers/FideleCtrl.dart';
import 'package:flutter_fidele/pages/BrouillonPage.dart';
import 'package:flutter_fidele/pages/FidelesPage.dart';
import 'package:flutter_fidele/pages/LoginPage.dart';
import 'package:provider/provider.dart';

class MonApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FideleCtrl())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
