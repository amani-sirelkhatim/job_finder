import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/label.dart';

class jobs extends StatefulWidget {
  const jobs({super.key});

  @override
  State<jobs> createState() => _jobsState();
}

class _jobsState extends State<jobs> {
  bool isempty = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(name: 'Offered Jobs :', color: AppColors.black, size: 20),
              Gap(50),
              isempty
                  ? Center(
                      child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/folder.png',
                          width: 100,
                        ),
                        Gap(20),
                        Text(
                          'no other jobs posted by this provider',
                          style: getBodyStyle(),
                        )
                      ],
                    ))
                  : SizedBox(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.grey.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('UI Designer',
                                          style: getBodyStyle(
                                              color: AppColors.black)),
                                      Text('usa',
                                          style: getSmallStyle(
                                              color: AppColors.grey)),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text('15,00/month',
                                          style: getBodyStyle(
                                              color: AppColors.black)),
                                      Text(
                                        '2days ago',
                                        style: getSmallStyle(
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gap(10),
                          itemCount: 4),
                    )
            ],
          ),
        ));
  }
}
