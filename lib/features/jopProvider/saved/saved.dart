import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jopProvider/saved/widgets/canidatetile2.dart';

class savedCanidates extends StatefulWidget {
  const savedCanidates({super.key});

  @override
  State<savedCanidates> createState() => _savedCanidatesState();
}

class _savedCanidatesState extends State<savedCanidates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Saved Canidates',
          style: getTitleStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return canidateTile2(
                          name: 'amani',
                          jobtitle: 'Software Developer',
                          image: 'assets/icons/profile.png',
                          about:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
                    },
                    separatorBuilder: (context, index) => Gap(10),
                    itemCount: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
