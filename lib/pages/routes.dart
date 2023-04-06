import 'package:find/authentication/login_page.dart';
import 'package:find/authentication/register_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routeMap = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const Register(),
};
