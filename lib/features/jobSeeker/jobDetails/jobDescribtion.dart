import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/apply.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/tabbar.dart';

class description extends StatefulWidget {
  const description({super.key});

  @override
  State<description> createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: getTitleStyle(),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
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
          Gap(15),
          GestureDetector(
            child: Image.asset(
              'assets/icons/share.png',
              width: 20,
            ),
          ),
          Gap(10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/google.png',
                    width: 100,
                  ),
                ),
                Gap(10),
                Text(
                  'Product Designer',
                  style: getTitleStyle(),
                ),
                Text(
                  'Google',
                  style: getBodyStyle(color: AppColors.grey),
                ),
                Gap(20),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/placeholder.png',
                        color: AppColors.primary,
                      ),
                      Text(
                        'USA',
                        style: getSmallStyle(),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Image.asset(
                        'assets/icons/payroll.png',
                        color: AppColors.primary,
                      ),
                      Text(
                        '16k/mon',
                        style: getSmallStyle(),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Image.asset(
                        'assets/icons/stop-watch.png',
                        color: AppColors.primary,
                      ),
                      Text(
                        'Full Time',
                        style: getSmallStyle(),
                      ),
                    ],
                  ),
                ),
                Gap(20)
              ],
            ),
            tabbar()
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
          push(context, apply());
        },
        text: 'Apply',
        bgcolor: AppColors.primary,
      ),
    );
  }
}
