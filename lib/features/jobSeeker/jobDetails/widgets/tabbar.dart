import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/details.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/jobs.dart';
import 'package:job_finder/features/jobSeeker/jobDetails/widgets/provider.dart';

class tabbar extends StatefulWidget {
  const tabbar({super.key});

  @override
  State<tabbar> createState() => _tabbarState();
}

class _tabbarState extends State<tabbar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            ButtonsTabBar(
              backgroundColor: AppColors.primary,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: TextStyle(color: Colors.black),
              labelStyle: getBodyStyle(
                  fontWeight: FontWeight.bold, color: AppColors.white),
              // TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "Job Description",
                ),
                Tab(
                  text: "Provider",
                ),
                Tab(
                  text: 'Jobs',
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[details(), provider(), jobs()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
