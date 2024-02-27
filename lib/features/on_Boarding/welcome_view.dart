import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/auth/presentation/view/login.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Gap(50),
              Image.asset('assets/images/pic-joinUs.png',
                  color: AppColors.primary),
              Spacer(
                flex: 1,
              ),
              Container(
                height: 380,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100))),
                child: Column(
                  children: [
                    Gap(60),
                    Text('As a',
                        style: getTitleStyle(
                            color: AppColors.white, fontSize: 40)),
                    Gap(60),
                    CustomButton(
                      onTap: () {
                        pushWithReplacment(
                            context,
                            login(
                              type: 0,
                            ));
                      },
                      width: 250,
                      text: 'Job Seeker',
                      bgcolor: AppColors.white,
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    Gap(30),
                    CustomButton(
                      onTap: () {
                        pushWithReplacment(
                            context,
                            login(
                              type: 1,
                            ));
                      },
                      width: 250,
                      text: 'Job Provider',
                      bgcolor: AppColors.white,
                      style: getTitleStyle(color: AppColors.primary),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
