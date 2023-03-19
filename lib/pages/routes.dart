import 'package:find/pages/auth/login.dart';
import 'package:find/pages/auth/register.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routeMap = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const Register(),
};
