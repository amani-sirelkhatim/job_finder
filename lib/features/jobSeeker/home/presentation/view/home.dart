import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/widgets/header.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/widgets/popularJobs.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/widgets/suggestedJobs.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const header(),
            const popularJobs(),
            const suggestedJobs()
          ]),
        ),
      ),
    );
  }
}
