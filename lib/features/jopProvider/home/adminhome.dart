import 'package:flutter/material.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jopProvider/addJobPost/presentation/view/addpost.dart';
import 'package:job_finder/features/jopProvider/home/widgets/adminheader.dart';
import 'package:job_finder/features/jopProvider/home/widgets/adminsearch.dart';
import 'package:job_finder/features/jopProvider/home/widgets/posts.dart';
import 'package:job_finder/features/jopProvider/home/widgets/speclizations.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                adminHeader(),
                adminSearch(),
                speclizations(),
                posts(),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0, // Adjust the bottom position as needed
            right: 16.0, // Adjust the right position as needed
            child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              shape: CircleBorder(),
              onPressed: () {
                push(context, AddPost());
              },
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
