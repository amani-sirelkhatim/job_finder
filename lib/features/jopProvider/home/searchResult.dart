import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/canidateadmin.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/canProfile.dart';

class searchresult extends StatefulWidget {
  const searchresult({super.key});

  @override
  State<searchresult> createState() => _searchresultState();
}

class _searchresultState extends State<searchresult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search Results',
          style: getTitleStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Results: 3',
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          push(
                              context,
                              canProfile(
                                useremail: '',
                              ));
                        },
                        child: const canidateAdminSearch(
                            name: 'amani',
                            jobtitle: 'Software Develober',
                            image: 'assets/icons/profile.png',
                            about:
                                ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(10),
                    itemCount: 3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
