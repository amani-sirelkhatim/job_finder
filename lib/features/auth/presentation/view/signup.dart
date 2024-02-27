import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/email_validator.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';

import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/educationInfo1.dart';
import 'package:job_finder/features/auth/presentation/view/login.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:job_finder/features/jobSeeker/nav.dart';

class signup extends StatefulWidget {
  const signup({super.key, required this.type});
  final int type;
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String datepicked = '';
  String gendertype = '';
  bool isVisable = true;
  int gender = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          pushWithReplacment(context, education());
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
        body: SingleChildScrollView(
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
                const Gap(15),
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Birth Date:',
                                    style:
                                        getTitleStyle(color: AppColors.primary),
                                  ),
                                  const Gap(10),
                                  TextFormField(
                                    readOnly: true,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _ageController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        labelStyle: getBodyStyle(),
                                        hintText: datepicked,
                                        suffixIcon: GestureDetector(
                                            onTap: () async {
                                              var datePicked = await DatePicker
                                                  .showSimpleDatePicker(
                                                context,
                                                // initialDate: DateTime(2020),
                                                firstDate: DateTime(1980),
                                                lastDate: DateTime(2030),
                                                dateFormat: "dd-MMMM-yyyy",
                                                locale:
                                                    DateTimePickerLocale.en_us,
                                                looping: true,
                                              );

                                              final snackBar = SnackBar(
                                                  content: Text(
                                                      "Date Picked $datePicked"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              setState(() {
                                                _ageController.text =
                                                    datePicked.toString();
                                              });
                                            },
                                            child: Icon(Icons.calendar_month,
                                                color: AppColors.primary))),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Birth Date';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('gender:',
                                      style: getTitleStyle(
                                          color: AppColors.primary)),
                                  ListTile(
                                    title: Text('Male',
                                        style: getBodyStyle(fontSize: 15)),
                                    leading: Radio<int>(
                                      value: 1,
                                      groupValue: gender,
                                      activeColor: AppColors
                                          .primary, // Change the active radio button color here
                                      fillColor: MaterialStateProperty.all(AppColors
                                          .primary), // Change the fill color when selected
                                      splashRadius:
                                          20, // Change the splash radius when clicked
                                      onChanged: (int? value) {
                                        setState(() {
                                          gender = value!;
                                          // gendertype = 'male';
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Female',
                                      style: getBodyStyle(fontSize: 15),
                                    ),
                                    leading: Radio<int>(
                                      value: 2,
                                      groupValue: gender,
                                      activeColor: AppColors
                                          .primary, // Change the active radio button color here
                                      fillColor: MaterialStateProperty.all(AppColors
                                          .primary), // Change the fill color when selected
                                      splashRadius:
                                          25, // Change the splash radius when clicked
                                      onChanged: (int? value) {
                                        setState(() {
                                          gender = value!;
                                          //   gendertype = 'female';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
                            label: const Text('Address'),
                            labelStyle: getBodyStyle(),
                            hintText: 'Enter Your Address  ',
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
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
                        const Gap(20),
                        CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (gender == 1) {
                                  setState(() {
                                    gendertype = 'male';
                                  });
                                } else {
                                  setState(() {
                                    gendertype = 'female';
                                  });
                                }
                                context.read<AuthCubit>().regestirUser(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    Address: _addressController.text,
                                    password: _passwordController.text,
                                    phone: _phoneController.text,
                                    birthdate:
                                        _ageController.text.substring(0, 11),
                                    gender: gendertype);
                              }
                              print(
                                _ageController.text.substring(0, 11),
                              );
                              // pushWithReplacment(context, education());
                            },
                            width: double.infinity,
                            text: 'Next',
                            bgcolor: AppColors.primary),
                        const Gap(60),
                      ],
                    ))
              ],
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
