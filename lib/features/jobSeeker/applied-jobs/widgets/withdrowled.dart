import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jobSeeker/applied-jobs/widgets/applicationtile.dart';

class withdrowl extends StatefulWidget {
  const withdrowl({super.key});

  @override
  State<withdrowl> createState() => _withdrowlState();
}

class _withdrowlState extends State<withdrowl> {
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
                  'Withdowled Applications',
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
                        return applicationTile(
                            withdowl: 0,
                            tilte: 'Google',
                            subtilte: 'Ui Ux Designer ',
                            image: 'assets/icons/google.png',
                            salary: '15,000');
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
