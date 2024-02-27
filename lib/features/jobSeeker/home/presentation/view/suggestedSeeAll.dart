import 'package:flutter/material.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/jobDescribtion.dart';
import 'package:job_finder/core/widgets/jobtile2.dart';

class suggestedSeeAll extends StatefulWidget {
  const suggestedSeeAll({super.key});

  @override
  State<suggestedSeeAll> createState() => _suggestedSeeAllState();
}

class _suggestedSeeAllState extends State<suggestedSeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggested Jobs'),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  child: GestureDetector(
                onTap: () {
                  push(context, description());
                },
                child: jobetile(
                    tilte: 'UI ux Designer',
                    subtilte: 'Google / Calafonia USA',
                    image: 'assets/icons/google.png',
                    salary: '15,000'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
