import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/widgets/jobtile.dart';
import 'package:job_finder/core/widgets/label.dart';

class posts extends StatefulWidget {
  const posts({super.key});

  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              label(name: 'Your Job Posts :', color: AppColors.black, size: 20),
            ],
          ),
          SizedBox(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return jobpost(
                      tilte: 'ui ux',
                      subtilte: 'designer',
                      image: 'assets/icons/google.png',
                      salary: '10,000');
                },
                separatorBuilder: (context, index) => Gap(10),
                itemCount: 4),
          )
        ],
      ),
    );
  }
}
