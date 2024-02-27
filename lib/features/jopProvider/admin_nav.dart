import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jopProvider/applications/applications.dart';
import 'package:job_finder/features/jopProvider/chats/adminmessage.dart';
import 'package:job_finder/features/jopProvider/home/adminhome.dart';
import 'package:job_finder/features/jopProvider/profile/admin_profile.dart';
import 'package:job_finder/features/jopProvider/saved/saved.dart';

class adminNav extends StatefulWidget {
  const adminNav({super.key});

  @override
  State<adminNav> createState() => _adminNavState();
}

class _adminNavState extends State<adminNav> {
  List<Widget> pages = [
    const AdminHome(),
    const savedCanidates(),
    const applications(),
    const adminmessage(),
    const adminProfile()
  ];

  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
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
                  color: AppColors.primary,
                ),
                label: 'Applications',
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
                  color: AppColors.primary,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
        body: pages[pageindex]);
  }
}
