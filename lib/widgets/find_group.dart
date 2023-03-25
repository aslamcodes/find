import 'package:find/classes/user_finds.dart';
import 'package:find/widgets/find_circle.dart';
import 'package:flutter/material.dart';

class FindGroupWidget extends StatelessWidget {
  final List<Find> finds;
  final String username;

  const FindGroupWidget(
      {super.key, required this.finds, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color.fromRGBO(240, 240, 240, 1),
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
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    Text("$username's finds"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.favorite_outline_rounded),
                    Icon(Icons.more_vert_rounded)
                  ],
                )
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
