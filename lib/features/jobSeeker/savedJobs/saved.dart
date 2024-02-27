import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';

import 'package:job_finder/core/widgets/jobtile2.dart';

class saved extends StatefulWidget {
  const saved({super.key});

  @override
  State<saved> createState() => _savedState();
}

class _savedState extends State<saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Jobs',
          style: getTitleStyle(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  // Spacer(),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'See All',
                  //       style: getSmallStyle(color: AppColors.primary),
                  //     ))
                ],
              ),
              SizedBox(
                  child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return jobetile(
                      tilte: 'UI ux Designer',
                      subtilte: 'Google / Calafonia USA',
                      image: 'assets/icons/google.png',
                      salary: '15,000');
                },
                itemCount: 4,
                separatorBuilder: (context, index) => Gap(20),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
