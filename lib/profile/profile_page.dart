import 'package:find/authentication/auth_controller.dart';
import 'package:find/interfaces/user_finds.dart';
import 'package:find/model/user_model.dart';
import 'package:find/profile/profile_service.dart';
import 'package:find/widgets/find_circle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final AuthController _authController = const AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          profileHeader(context),
          const SizedBox(
            height: 30,
          ),
          const ProfileFinds(),
          const Spacer(flex: 5),
          OutlinedButton(
              onPressed: () {
                // Todo: Fix this bullshit
                _authController.logout();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Color.fromRGBO(0, 129, 159, 1)),
              )),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Column profileHeader(BuildContext context) {
    return Column(
      children: [
        const ProfileAvatar(
          radius: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Text("@${context.read<UserProvider>().currentUser?.username}",
            style: GoogleFonts.lobster(
                textStyle: const TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(0, 129, 159, 1),
            )))
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 10});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage:
          NetworkImage(context.read<UserProvider>().currentUser!.profileImage),
    );
  }
}

class ProfileFinds extends StatefulWidget {
  const ProfileFinds({Key? key}) : super(key: key);

  @override
  State<ProfileFinds> createState() => _ProfileFindsState();
}

class _ProfileFindsState extends State<ProfileFinds> {
  late Future<List<Find>> _profileUserFinds;
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _profileUserFinds =
        _profileService.getUserFinds(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    String username = context.read<UserProvider>().currentUser!.username;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const ProfileAvatar(
                  radius: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$username's finds",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: const [Icon(Icons.edit), Icon(Icons.more_vert)],
            )
          ],
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<Find>>(
          future: _profileUserFinds,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 10,
                    runSpacing: 15,
                    children: snapshot.data!
                        .map((e) => FindCircleWidget(findData: e))
                        .toList()),
              );
            } else if (snapshot.hasError) {
              return const Text('Some Unknown error have Ocurred');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}
