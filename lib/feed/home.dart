import 'dart:async';
import 'package:find/authentication/auth_controller.dart';
import 'package:find/feed/feed_controller.dart';
import 'package:find/interfaces/user_finds.dart';
import 'package:find/model/user_model.dart';
import 'package:find/widgets/common/new_find_fab.dart';
import 'package:find/widgets/find_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late Future<List<UserFinds>> futureUserFinds;
  final FeedsController _feedsController = FeedsController();
  final AuthController _authController = AuthController();
  late TextEditingController _searchController;

  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      // print('Performing search for: ${_searchController.text}');
    });
  }

  @override
  void initState() {
    super.initState();
    // Todo: Separate Firebase
    _searchController = TextEditingController();
    futureUserFinds = _feedsController
        .getFeedsForUser(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Consumer<UserProvider>(
                builder: (context, value, child) => CircleAvatar(
                  backgroundColor: Colors.blue,
                  foregroundImage: NetworkImage(value
                          .currentUser?.profileImage ??
                      "https://static.wikia.nocookie.net/despicableme/images/a/ac/BobYay.png/revision/latest?cb=20220129132453"),
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 129, 159, 1),
                    shape: BoxShape.circle),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.search),
              ),
            )
          ],
          title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                "finds",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                  fontSize: 35,
                  color: Color.fromRGBO(0, 129, 159, 1),
                )),
              )),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: FutureBuilder<List<UserFinds>>(
          future: futureUserFinds,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => FindGroupWidget(
                    finds: snapshot.data![index].finds,
                    username: snapshot.data![index].user,
                    profile_image: snapshot.data![index].userProfile,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Such');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: const NewFindFAB(),
      ),
    );
  }
}
