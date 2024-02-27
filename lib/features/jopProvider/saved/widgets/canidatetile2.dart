import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';

class canidateTile2 extends StatefulWidget {
  const canidateTile2(
      {super.key,
      required this.name,
      required this.jobtitle,
      required this.image,
      required this.about});
  final String name;
  final String jobtitle;
  final String image;
  final String about;

  @override
  State<canidateTile2> createState() => _canidateTile2State();
}

class _canidateTile2State extends State<canidateTile2> {
  bool isExpanded = false;
  bool issaved = true;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary.withOpacity(.1)),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              widget.image,
              width: 30,
            ),
            title: Text(
              widget.name,
              style: getBodyStyle(),
            ),
            subtitle: Text(
              widget.jobtitle,
              style: getSmallStyle(color: AppColors.grey, fontSize: 12),
            ),
            trailing: GestureDetector(
              onTap: toggleSaved,
              child: issaved
                  ? Image.asset(
                      'assets/icons/unsave.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/icons/bookmark.png',
                      width: 20,
                    ),
            ),
          ),
          Row(
            children: [
              label(
                  name: 'About :',
                  color: AppColors.primary.withOpacity(.5),
                  size: 14),
            ],
          ),
          Gap(10),
          ExpandableText(
            widget.about,
            expandText: 'Read more',
            collapseText: 'Read less',
            maxLines: 2,
            expanded: isExpanded,
            onExpandedChanged: (bool expanded) {
              setState(() {
                isExpanded = expanded;
              });
            },
            linkColor: AppColors.primary,
          ),
          Gap(10),
        ],
      ),
    );
  }
}
