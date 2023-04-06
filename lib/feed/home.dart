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
  @override
  void initState() {
    super.initState();
    // Todo: Separate Firebase
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
            onTap: () {
              _authController.logout();
            },
            child: Container(
              // margin: const EdgeInsets.all(17),
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundImage: NetworkImage(context
                        .read<UserProvider>()
                        .currentUser
                        ?.profileImage ??
                    "https://static.wikia.nocookie.net/despicableme/images/a/ac/BobYay.png/revision/latest?cb=20220129132453"),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                print(await futureUserFinds);
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
          title: Text(
            "finds",
            style: GoogleFonts.lobster(
                textStyle: const TextStyle(
              fontSize: 35,
              color: Color.fromRGBO(0, 129, 159, 1),
            )),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: FutureBuilder<List<UserFinds>>(
          future: futureUserFinds,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => FindGroupWidget(
                    finds: snapshot.data![index].finds,
                    username: snapshot.data![index].user,
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
            return const CircularProgressIndicator();
          },
        ),
        floatingActionButton: const NewFindFAB(),
      ),
    );
  }
}
