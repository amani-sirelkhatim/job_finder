import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jopProvider/applications/widgets/accepted_canidates.dart';
import 'package:job_finder/features/jopProvider/applications/widgets/pending-canidates.dart';
import 'package:job_finder/features/jopProvider/applications/widgets/rejected_canidates.dart';

class applications extends StatefulWidget {
  const applications({super.key});

  @override
  State<applications> createState() => _applicationsState();
}

class _applicationsState extends State<applications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Apllications',
          style: getTitleStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [pendinCan(), acceptedCan(), rejectedCan()],
        ),
      ),
    );
  }
}
