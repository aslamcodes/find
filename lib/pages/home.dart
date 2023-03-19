import 'package:find/widgets/common/NewFindFAB.dart';
import 'package:find/widgets/find_circle.dart';
import 'package:find/widgets/find_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserFinds {
  final List<Find> finds;
  final String user;
  const UserFinds({required this.finds, required this.user});
}

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const CircleAvatar(backgroundColor: Colors.blue),
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
