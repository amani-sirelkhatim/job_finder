import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/auth/presentation/view/forget_passsord/code_verivication.dart';

import 'package:job_finder/features/on_Boarding/welcome_view.dart';

class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  int choice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              pushWithReplacment(context, welcome());
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Forgot Password',
            style: getTitleStyle(color: AppColors.black, fontSize: 30),
          ),
          Gap(20),
          Text(
            'select which contact details should we use to reset your password',
            style: getSmallStyle(color: AppColors.grey, fontSize: 15),
          ),
          Gap(10),
          Image.asset(
            'assets/images/forgot.png',
            height: 300,
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    choice = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: choice == 1 ? AppColors.primary : AppColors.grey,
                      )),
                  child: Row(
                    children: [
                      Gap(20),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: choice == 1
                            ? AppColors.primary
                            : AppColors.grey.withOpacity(.3),
                        child: Icon(
                          Icons.sms_outlined,
                          color:
                              choice == 1 ? AppColors.white : AppColors.primary,
                        ),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send OTP via SMS',
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.6)),
                          ),
                          Text(
                            '+20100111234',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    choice = 2;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: choice == 2 ? AppColors.primary : AppColors.grey,
                      )),
                  child: Row(
                    children: [
                      Gap(20),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: choice == 2
                            ? AppColors.primary
                            : AppColors.grey.withOpacity(.3),
                        child: Icon(
                          Icons.email_outlined,
                          color:
                              choice == 2 ? AppColors.white : AppColors.primary,
                        ),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send OTP via Email',
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.6)),
                          ),
                          Text(
                            'amani@gmail.com',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gap(20),
          CustomButton(
            onTap: () {
              push(context, codeV());
            },
            text: 'Continue',
            bgcolor: AppColors.primary,
            width: double.infinity,
          )
        ]),
      ),
    );
  }
}
