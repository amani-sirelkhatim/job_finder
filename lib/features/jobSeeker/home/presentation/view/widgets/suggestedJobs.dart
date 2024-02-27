import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';

import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/jobDescribtion.dart';

import 'package:job_finder/core/widgets/jobtile2.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/popularSeeAll.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/suggestedSeeAll.dart';

class suggestedJobs extends StatefulWidget {
  const suggestedJobs({super.key});

  @override
  State<suggestedJobs> createState() => _suggestedJobsState();
}

class _suggestedJobsState extends State<suggestedJobs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Suggested Jobs',
                style: getTitleStyle(
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    push(context, suggestedSeeAll());
                  },
                  child: Text(
                    'See All',
                    style: getSmallStyle(color: AppColors.primary),
                  ))
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  push(context, description());
                },
                child: jobetile(
                    tilte: 'UI ux Designer',
                    subtilte: 'Google / Calafonia USA',
                    image: 'assets/icons/google.png',
                    salary: '15,000'),
              );
            },
            itemCount: 4,
            separatorBuilder: (context, index) => Gap(20),
          )
        ],
      ),
    );
  }
}
