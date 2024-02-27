import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jopProvider/applications/widgets/canidate_tile.dart';

class acceptedCan extends StatefulWidget {
  const acceptedCan({super.key});

  @override
  State<acceptedCan> createState() => _acceptedCanState();
}

class _acceptedCanState extends State<acceptedCan> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary.withOpacity(.2)),
              borderRadius: BorderRadius.circular(10)),
          child: ExpandablePanel(
            header: Row(
              children: [
                Text(
                  'Accepted Applications',
                  style: getTitleStyle(color: AppColors.black.withOpacity(.7)),
                ),
                Gap(10),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary.withOpacity(.2),
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: AppColors.white,
                    child: Text(
                      '3',
                      style: getSmallStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            collapsed: SizedBox(),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return canidateTile(
                          name: 'Amani Sirelkhetim',
                          jobtitle: 'Software Developer',
                          image: 'assets/icons/profile.png',
                          applicationLetter:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          withdowl: 0,
                          job: 'Full Stack Developer',
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10),
                      itemCount: 3),
                )
              ],
            ),
            theme: ExpandableThemeData(
              iconColor: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
