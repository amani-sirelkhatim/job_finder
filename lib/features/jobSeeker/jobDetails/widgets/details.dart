import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/widgets/label.dart';

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpandableText(
              '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
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
            Gap(20),
            Row(
              children: [
                label(
                    name: 'Responcibilites', color: AppColors.black, size: 20),
              ],
            ),
            Gap(20),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/accept.png',
                        width: 30,
                      ),
                      Gap(20),
                      Text('data')
                    ],
                  ),
                );
              },
              itemCount: 4,
              separatorBuilder: (context, index) => Gap(20),
            )
          ],
        ),
      ),
    );
  }
}
