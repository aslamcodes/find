import 'package:find/classes/user_finds.dart';
import 'package:find/model/user_model.dart';
import 'package:find/widgets/common/NewFindFAB.dart';
import 'package:find/widgets/find_circle.dart';
import 'package:find/widgets/find_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const List<UserFinds> dummy = [
  UserFinds(user: "Mohamed Aslam", finds: [
    Find(
        type: FindSMEnum.youtube,
        dataURL: "https://www.youtube.com/watch?v=AIc671o9yCI"),
    Find(
        type: FindSMEnum.youtube,
        dataURL: "https://www.youtube.com/watch?v=AIc671o9yCI"),
    Find(
        type: FindSMEnum.facebook,
        dataURL:
            "https://www.facebook.com/groups/781303619106745/permalink/1313804055856696/")
  ]),
  UserFinds(user: "Angu", finds: [
    Find(
        type: FindSMEnum.spotify,
        dataURL:
            "https://open.spotify.com/track/6H1hnJRQOGQ9djPL3jNu9G?si=6224c7a403d94f6f"),
    Find(
        type: FindSMEnum.spotify,
        dataURL:
            "https://open.spotify.com/track/6H1hnJRQOGQ9djPL3jNu9G?si=6224c7a403d94f6f"),
    Find(
        type: FindSMEnum.youtube,
        dataURL: "https://www.youtube.com/watch?v=AIc671o9yCI"),
  ]),
];

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.read<UserProvider>().currentUser?.username);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
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
              onTap: () {},
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: dummy.length,
            itemBuilder: (context, index) => FindGroupWidget(
              finds: dummy[index].finds,
              username: dummy[index].user,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        ),
        floatingActionButton: const NewFindFAB(),
      ),
    );
  }
}
