import 'package:find/pages/home.dart';
import 'package:find/pages/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePageWidget(),
    initialRoute: '/',
    title: "finds",
    routes: routeMap,
  ));
}
