import 'package:flutter/material.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/about.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/cv.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/experiance.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/images.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/links.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/profileheader.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/skils.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            proheader(),
            about(),
            cv(),
            skils(),
            experiance(),
            links(),
            images()
          ],
        ),
      ),
    );
  }
}
