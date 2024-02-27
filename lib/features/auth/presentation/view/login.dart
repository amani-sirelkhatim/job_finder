import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/email_validator.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';
import 'package:job_finder/features/auth/presentation/view/forget_passsord/forget.dart';
import 'package:job_finder/features/auth/presentation/view/job-provider/adminsignup.dart';
import 'package:job_finder/features/auth/presentation/view/signup.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:job_finder/features/jobSeeker/nav.dart';
import 'package:job_finder/features/jopProvider/admin_nav.dart';

class login extends StatefulWidget {
  const login({super.key, required this.type});
  final int type;
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (widget.type == 1) {
            pushWithReplacment(context, adminNav());
          } else {
            pushWithReplacment(context, nav());
          }
          print('Donnnneeeeeeee');
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(100),
                  Text(
                    'Lets Get you In!!',
                    style: getTitleStyle(
                        color: AppColors.black.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  Gap(10),
                  Text(
                    'Welcome Back',
                    style: getBodyStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(.2)),
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Gap(10),
                                Text(
                                  'Google',
                                  style: getBodyStyle(
                                      color: AppColors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(.2)),
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/facebook.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Gap(10),
                                Text(
                                  'Facebook',
                                  style: getBodyStyle(
                                      color: AppColors.black, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 1,
                        color: AppColors.grey.withOpacity(.5),
                      ),
                      Spacer(),
                      Text(
                        'or login With',
                        style: getSmallStyle(color: AppColors.grey),
                      ),
                      Spacer(),
                      Container(
                        width: 100,
                        height: 1,
                        color: AppColors.grey.withOpacity(.5),
                      ),
                    ],
                  ),
                  Gap(30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text('Email'),
                      labelStyle: getBodyStyle(),
                      hintText: 'Enter Your Email',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailValidate(value)) {
                        return 'the email is wrong!!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(40),
                  TextFormField(
                    style: TextStyle(color: AppColors.black),
                    obscureText: isVisable,
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
                              isVisable = !isVisable;
                            });
                          },
                          icon: Icon((isVisable)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.primary,
                      ),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'please enter your password';
                      return null;
                    },
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            push(context, forget());
                          },
                          child: Text(
                            'Forgot Password?!',
                            style: getSmallStyle(color: AppColors.primary),
                          )),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          width: 300,
                          text: 'Login',
                          bgcolor: AppColors.primary.withOpacity(.7)),
                    ],
                  ),
                  Gap(20),
                  Gap(60),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dont have an account?',
              style: getSmallStyle(color: AppColors.grey),
            ),
            TextButton(
                onPressed: () {
                  if (widget.type == 0) {
                    pushWithReplacment(
                        context,
                        signup(
                          type: widget.type,
                        ));
                  } else {
                    pushWithReplacment(
                        context,
                        adminSignup(
                          type: widget.type,
                        ));
                  }
                },
                child: Text(
                  'Regestir now',
                  style: getSmallStyle(color: AppColors.primary),
                ))
          ],
        ),
      ),
    );
  }
}
