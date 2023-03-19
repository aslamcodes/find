import 'package:find/widgets/find_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

enum FindSMEnum {
  spotify('assets/icons/spotify.svg'),
  youtube('assets/icons/youtube.svg'),
  facebook('assets/icons/facebook.svg');

  const FindSMEnum(this.name);

  final String name;
}

class FindCircleWidget extends StatelessWidget {
  const FindCircleWidget({super.key, required this.findData});

  final Find findData;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse(findData.dataURL),
                  mode: LaunchMode.externalApplication);
            },
            child: SvgPicture.asset(findData.type.name,
                semanticsLabel: 'spotify Logo')));
  }
}
