import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/canAbout.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/canExperiance.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/canSkills.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/cancv.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/caneducation.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/canheader.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/canimages.dart';

class canProfile extends StatefulWidget {
  const canProfile({
    super.key,
    required this.useremail,
  });
  final String useremail;
  @override
  State<canProfile> createState() => _canProfileState();
}

class _canProfileState extends State<canProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary.withOpacity(.9),
      ),
      body: Column(
        children: [
          canHeader(
            useremail: widget.useremail,
          ),
          canAbout(
            useremail: widget.useremail,
          ),
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: AppColors.primary,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        text: " Education ",
                      ),
                      Tab(
                        text: " Cv ",
                      ),
                      Tab(
                        text: " Skills ",
                      ),
                      Tab(
                        text: " Experiance ",
                      ),
                      Tab(
                        text: " Work Done ",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        caneducation(
                          useremail: widget.useremail,
                        ),
                        cancv(
                          useremail: widget.useremail,
                        ),
                        canSkills(
                          useremail: widget.useremail,
                        ),
                        canExperiance(
                          useremail: widget.useremail,
                        ),
                        canimages(useremail: widget.useremail),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
        ],
      ),
    );
  }
}
