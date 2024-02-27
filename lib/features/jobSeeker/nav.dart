import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jobSeeker/applied-jobs/applied.dart';
import 'package:job_finder/features/jobSeeker/chats/chat.dart';
import 'package:job_finder/features/jobSeeker/chats/messges.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/home.dart';

import 'package:job_finder/features/jobSeeker/profile/profile.dart';
import 'package:job_finder/features/jobSeeker/savedJobs/saved.dart';

class nav extends StatefulWidget {
  const nav({super.key});

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
  List<Widget> pages = [home(), saved(), appliedjobs(), messages(), profile()];

  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: BottomBarDoubleBullet(
            selectedIndex: pageindex,
            onSelect: (index) {
              setState(() {
                pageindex = index;
              });
              // implement your select function here
            },
            items: [
              BottomBarItem(
                iconBuilder: (color) => Image.asset(
                  'assets/icons/home.png',
                  width: 30,
                  color: AppColors.primary.withOpacity(.7),
                ),
                label: 'Home',
              ),
              BottomBarItem(
                iconBuilder: (color) => Image.asset(
                  'assets/icons/saved.png',
                  width: 30,
                  color: AppColors.primary.withOpacity(.7),
                ),
                label: 'Saved',
              ),
              BottomBarItem(
                iconBuilder: (color) => Image.asset(
                  'assets/icons/applied.png',
                  width: 30,
                  color: AppColors.primary.withOpacity(.7),
                ),
                label: 'Applied',
              ),
              BottomBarItem(
                iconBuilder: (color) => Image.asset(
                  'assets/icons/chat.png',
                  width: 30,
                  color: AppColors.primary.withOpacity(.7),
                ),
                label: 'Messages',
              ),
              BottomBarItem(
                iconBuilder: (color) => Image.asset(
                  'assets/icons/profile.png',
                  width: 30,
                  color: AppColors.primary.withOpacity(.7),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
        body: pages[pageindex]);
  }
}
