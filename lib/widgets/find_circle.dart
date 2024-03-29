import 'package:find/interfaces/user_finds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class FindCircleWidget extends StatelessWidget {
  const FindCircleWidget({super.key, required this.findData});

  final Find findData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await launchUrl(Uri.parse(findData.dataURL),
              mode: LaunchMode.externalApplication);
        },
        child: SvgPicture.asset(findData.type.name,
            semanticsLabel: 'spotify Logo'));
  }
}
