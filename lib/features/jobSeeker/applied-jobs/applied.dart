import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

import 'package:job_finder/features/jobSeeker/applied-jobs/widgets/accepted.dart';
import 'package:job_finder/features/jobSeeker/applied-jobs/widgets/declined.dart';
import 'package:job_finder/features/jobSeeker/applied-jobs/widgets/pending.dart';
import 'package:job_finder/features/jobSeeker/applied-jobs/widgets/withdrowled.dart';

class appliedjobs extends StatefulWidget {
  const appliedjobs({super.key});

  @override
  State<appliedjobs> createState() => _appliedjobsState();
}

class _appliedjobsState extends State<appliedjobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Job Applications',
            style: getTitleStyle(color: AppColors.primary),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [pending(), accepted(), declined(), withdrowl()],
            ),
          ),
        ));
  }
}
