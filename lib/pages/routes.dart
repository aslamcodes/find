import 'package:find/authentication/login_page.dart';
import 'package:find/authentication/register_page.dart';
import 'package:find/profile/profile_page.dart';
import 'package:find/search/search_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routeMap = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const Register(),
  '/profile': (context) => const ProfilePage(),
  '/search': (context) => const SearchPage()
};
