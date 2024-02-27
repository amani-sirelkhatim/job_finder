import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/auth/presentation/view/forget_passsord/code_verivication.dart';

import 'package:job_finder/features/jobSeeker/nav.dart';

class reset extends StatefulWidget {
  const reset({super.key});

  @override
  State<reset> createState() => _resetState();
}

class _resetState extends State<reset> {
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool isVisable1 = true;
  bool isVisable2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              pushWithReplacment(context, codeV());
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter New Password',
                style: getTitleStyle(color: AppColors.black, fontSize: 30),
              ),
              Gap(20),
              Text(
                'please enter your new password',
                style: getSmallStyle(color: AppColors.grey, fontSize: 15),
              ),
              Gap(10),
              Image.asset('assets/images/reset.png'),
              Gap(10),
              TextFormField(
                style: TextStyle(color: AppColors.black),
                obscureText: isVisable1,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusColor: AppColors.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text('Password'),
                  labelStyle: getBodyStyle(),
                  hintText: '********',
                  suffixIcon: IconButton(
                      color: AppColors.primary,
                      onPressed: () {
                        setState(() {
                          isVisable1 = !isVisable1;
                        });
                      },
                      icon: Icon((isVisable1)
                          ? Icons.remove_red_eye
                          : Icons.visibility_off_rounded)),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.primary,
                  ),
                ),
                controller: _passwordController1,
                validator: (value) {
                  if (value!.isEmpty) return 'please enter your password';
                  return null;
                },
              ),
              Gap(20),
              TextFormField(
                style: TextStyle(color: AppColors.black),
                obscureText: isVisable2,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusColor: AppColors.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text('Password'),
                  labelStyle: getBodyStyle(),
                  hintText: '********',
                  suffixIcon: IconButton(
                      color: AppColors.primary,
                      onPressed: () {
                        setState(() {
                          isVisable2 = !isVisable2;
                        });
                      },
                      icon: Icon((isVisable2)
                          ? Icons.remove_red_eye
                          : Icons.visibility_off_rounded)),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.primary,
                  ),
                ),
                controller: _passwordController2,
                validator: (value) {
                  if (value!.isEmpty) return 'please enter your password';
                  return null;
                },
              ),
              Gap(20),
              CustomButton(
                  onTap: () {
                    pushWithReplacment(context, nav());
                  },
                  width: double.infinity,
                  text: 'Save',
                  bgcolor: AppColors.primary)
            ],
          ),
        ),
      ),
    );
  }
}
