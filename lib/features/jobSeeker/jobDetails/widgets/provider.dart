import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

class provider extends StatefulWidget {
  const provider({super.key});

  @override
  State<provider> createState() => _providerState();
}

class _providerState extends State<provider> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Row(
          children: [
            Image.asset(
              'assets/icons/identification.png',
              color: AppColors.primary,
              width: 30,
            ),
            Gap(20),
            Text(
              'name',
              style: getBodyStyle(),
            )
          ],
        ),
        Gap(10),
        Row(
          children: [
            Image.asset(
              'assets/icons/web.png',
              color: AppColors.primary,
              width: 30,
            ),
            Gap(20),
            Text(
              'website',
              style: getBodyStyle(),
            )
          ],
        ),
        Gap(10),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
              size: 30,
            ),
            Gap(20),
            Text(
              'data',
              style: getBodyStyle(),
            )
          ],
        ),
        Gap(20),
        ExpandableText(
          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
          expandText: 'Read more',
          collapseText: 'Read less',
          maxLines: 4,
          expanded: isExpanded,
          onExpandedChanged: (bool expanded) {
            setState(() {
              isExpanded = expanded;
            });
          },
          linkColor: AppColors.primary,
        ),
      ],
    );
  }
}
