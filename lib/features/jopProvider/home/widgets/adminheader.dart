import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

class adminHeader extends StatefulWidget {
  const adminHeader({super.key});

  @override
  State<adminHeader> createState() => _adminHeaderState();
}

class _adminHeaderState extends State<adminHeader> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroung.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Welcome, Amani',
                            style: getTitleStyle(
                                color: AppColors.white.withOpacity(.7),
                                fontSize: 20),
                          ),
                          Gap(5),
                          Image.asset('assets/icons/wave.png', width: 25)
                        ],
                      ),
                      Text(
                        'Let\'s find a canidate',
                        style:
                            getTitleStyle(color: AppColors.white, fontSize: 30),
                      ),
                    ],
                  ),
                  Gap(40),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/bell.png',
                      width: 25,
                      color: AppColors.white,
                    ),
                  ),
                  Gap(20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
