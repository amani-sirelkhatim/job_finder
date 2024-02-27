import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/email_validator.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';

import 'package:job_finder/features/auth/presentation/view/login.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:job_finder/features/jopProvider/admin_nav.dart';

class adminSignup extends StatefulWidget {
  const adminSignup({super.key, required this.type});
  final int type;

  @override
  State<adminSignup> createState() => _adminSignupState();
}

class _adminSignupState extends State<adminSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool isVisable = true;
  int accountType = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          pushWithReplacment(context, adminNav());
          print('Donnnneeeeeeee');
        } else if (state is RegisterErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  Text(
                    'Register Now !',
                    style: getTitleStyle(
                        color: AppColors.black.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const Gap(10),
                  Text(
                    'Enter your informatopn below',
                    style: getBodyStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(30),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: const Text('Name'),
                              labelStyle: getBodyStyle(),
                              hintText: 'Enter Your Name',
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: const Text('Email'),
                              labelStyle: getBodyStyle(),
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
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
                          const Gap(20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: const Text('Phone Number'),
                              labelStyle: getBodyStyle(),
                              hintText: 'Enter Your Phone Number ',
                              prefixIcon: Icon(
                                Icons.phone_android_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _addressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: const Text('City'),
                              labelStyle: getBodyStyle(),
                              hintText: 'Enter Your City  ',
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your city';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(20),
                          TextFormField(
                            style: TextStyle(color: AppColors.black),
                            obscureText: isVisable,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              focusColor: AppColors.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: const Text('Password'),
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
                              if (value!.isEmpty)
                                return 'please enter your password';
                              return null;
                            },
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type',
                                  style:
                                      getTitleStyle(color: AppColors.primary)),
                              ListTile(
                                title: Text('A Company',
                                    style: getBodyStyle(fontSize: 15)),
                                leading: Radio<int>(
                                  value: 1,
                                  groupValue: accountType,
                                  activeColor: AppColors
                                      .primary, // Change the active radio button color here
                                  fillColor: MaterialStateProperty.all(AppColors
                                      .primary), // Change the fill color when selected
                                  splashRadius:
                                      20, // Change the splash radius when clicked
                                  onChanged: (int? value) {
                                    setState(() {
                                      accountType = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'An Individual',
                                  style: getBodyStyle(fontSize: 15),
                                ),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: accountType,
                                  activeColor: AppColors
                                      .primary, // Change the active radio button color here
                                  fillColor: MaterialStateProperty.all(AppColors
                                      .primary), // Change the fill color when selected
                                  splashRadius:
                                      25, // Change the splash radius when clicked
                                  onChanged: (int? value) {
                                    setState(() {
                                      accountType = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          CustomButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().regestirAdmin(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      Address: _addressController.text,
                                      password: _passwordController.text,
                                      phone: _phoneController.text,
                                      type: accountType);
                                }
                              },
                              width: double.infinity,
                              text: 'Sign Up',
                              bgcolor: AppColors.primary),
                          const Gap(60),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: getSmallStyle(color: AppColors.grey),
            ),
            TextButton(
                onPressed: () {
                  pushWithReplacment(
                      context,
                      login(
                        type: widget.type,
                      ));
                },
                child: Text(
                  'Login now',
                  style: getSmallStyle(color: AppColors.primary),
                ))
          ],
        ),
      ),
    );
  }
}
