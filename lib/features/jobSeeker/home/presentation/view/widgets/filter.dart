import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jobSeeker/search/search.dart';

class filter extends StatefulWidget {
  const filter({super.key});

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  int radio1 = 0;
  int radio2 = 0;
  int radio3 = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                label(
                  name: 'Filter',
                  color: AppColors.black,
                  size: 20,
                ),
              ],
            ),
            Gap(20),
            Row(
              children: [
                label(
                  name: 'Sort by :',
                  color: AppColors.primary,
                  size: 15,
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Most Recent', style: getBodyStyle(fontSize: 15)),
              leading: Radio<int>(
                value: 1,
                groupValue: radio1,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 20, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio1 = value!;
                    print(radio1);
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Most Relevant',
                style: getBodyStyle(fontSize: 15),
              ),
              leading: Radio<int>(
                value: 2,
                groupValue: radio1,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 25, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio1 = value!;
                  });
                },
              ),
            ),
            //---------------------online/offline level----------------------
            Row(
              children: [
                label(
                  name: 'The Job is :',
                  color: AppColors.primary,
                  size: 15,
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Online', style: getBodyStyle(fontSize: 15)),
              leading: Radio<int>(
                value: 1,
                groupValue: radio2,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 15, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio2 = value!;
                    print(radio1);
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Offline',
                style: getBodyStyle(fontSize: 15),
              ),
              leading: Radio<int>(
                value: 2,
                groupValue: radio2,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 15, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio2 = value!;
                  });
                },
              ),
            ),
            //-----------------------------location-------------------------
            Row(
              children: [
                label(
                  name: 'Location :',
                  color: AppColors.primary,
                  size: 15,
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title:
                  Text('Current Location', style: getBodyStyle(fontSize: 15)),
              leading: Radio<int>(
                value: 1,
                groupValue: radio3,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 15, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio3 = value!;
                    print(radio1);
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Abroad',
                style: getBodyStyle(fontSize: 15),
              ),
              leading: Radio<int>(
                value: 2,
                groupValue: radio3,
                activeColor: AppColors
                    .primary, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(
                    AppColors.primary), // Change the fill color when selected
                splashRadius: 15, // Change the splash radius when clicked
                onChanged: (int? value) {
                  setState(() {
                    radio3 = value!;
                  });
                },
              ),
            ),

            Row(
              children: [
                Gap(50),
                CustomButton(
                  text: 'Clear All',
                  bgcolor: AppColors.primary,
                  onTap: () {
                    setState(() {
                      radio1 = 0;
                      radio2 = 0;
                      radio3 = 0;
                    });
                  },
                ),
                Gap(20),
                CustomButton(
                  text: 'Apply',
                  bgcolor: AppColors.primary,
                  onTap: () {
                    setState(() {
                      //  blur = false;
                      push(context, search());
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
