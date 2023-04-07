import 'package:find/interfaces/user_finds.dart';
import 'package:find/widgets/find_circle.dart';
import 'package:flutter/material.dart';

class FindGroupWidget extends StatelessWidget {
  final List<Find> finds;
  final String username;
  final String? profile_image;

  const FindGroupWidget(
      {super.key,
      required this.finds,
      required this.username,
      this.profile_image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(240, 240, 240, 1),
          borderRadius: BorderRadius.circular(10)),
      height: 130,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundImage: NetworkImage(profile_image!)),
                    const SizedBox(width: 10),
                    Text("$username's finds"),
                  ],
                ),
                const Icon(Icons.favorite_outline_rounded)
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Color.fromRGBO(203, 203, 203, 1),
            ),
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: finds.length,
                  itemBuilder: (context, index) => FindCircleWidget(
                        findData: finds[index],
                      )),
            ),
          ]),
    );
  }
}
