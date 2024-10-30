// ignore_for_file: prefer_const_constructors

import 'service.page.dart';
import 'package:flutter/material.dart';
import 'home.page.dart';
import 'register.page.dart';
import 'login.page.dart';
import 'service-portal.page.dart';
import 'notices.page.dart';
import 'service.register.dart';
import 'user.profile.dart';
import 'admin.profile.dart';
import 'user.info.dart';
import 'historico.page.dart' ;
import 'historico.teste.dart';
import 'service.list.dart';

class AjudaRPApp extends StatelessWidget {
  const AjudaRPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        "/home": (context) => HomePage(),
        "/portal": (context) => ServicePortalPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/notices": (context) => NoticesPage(),
        "/service": (context) => ServicePage(),
        "/service-register": (context) => ServiceRegisterPage(),
        "/user-profile": (context) => UserProfilePage(),
        "/admin-profile": (context) => AdminProfilePage(),
        "/user-info": (context) => UserInfo(),
        "/historico": (context) => HistoricoPage(),
        "/historico-teste": (context) => UserTeste(),
        "/list": (context) => ServiceListPage(),
      },
      initialRoute: "/home",
    );
  }
}
