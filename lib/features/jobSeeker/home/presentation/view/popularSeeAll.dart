import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';

import 'package:job_finder/core/widgets/jobtile2.dart';

class popularSeeAll extends StatefulWidget {
  const popularSeeAll({super.key});

  @override
  State<popularSeeAll> createState() => _popularSeeAllState();
}

class _popularSeeAllState extends State<popularSeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Jobs'),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
