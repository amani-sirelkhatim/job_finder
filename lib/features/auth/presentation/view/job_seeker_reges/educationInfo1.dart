import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/educationInfo2.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/jobTitle.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart' as CountryPickers;
import 'package:country_pickers/utils/utils.dart' as CountryUtils;

void showYearPicker(
    BuildContext context, TextEditingController yearController) async {
  final DateTime currentDate = DateTime.now();
  final int currentYear = currentDate.year;

  final List<int> years = List.generate(50, (index) => currentYear - index);

  int? selectedYear = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Year'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: years.length,
            itemBuilder: (BuildContext context, int index) {
              final year = years[index];
              return ListTile(
                title: Text(year.toString()),
                onTap: () {
                  Navigator.of(context).pop(year);
                },
              );
            },
          ),
        ),
      );
    },
  );

  if (selectedYear != null) {
    yearController.text = selectedYear.toString();
  }
}

class education extends StatefulWidget {
  const education({super.key});

  @override
  State<education> createState() => _educationState();
}

class _educationState extends State<education> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Country? _selectedCountry;
  String countryname = '';
  //TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _startyear = TextEditingController();
    final TextEditingController _endyear = TextEditingController();
    final TextEditingController _degreename = TextEditingController();
    final TextEditingController _uniname = TextEditingController();
    final TextEditingController _unicountry = TextEditingController();

    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          pushWithReplacment(context, complete_regestration());
          print('Donnnneeeeeeee');
        } else if (state is RegisterErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(40),
                Gap(20),
                Text(
                  'Acadimic Education:',
                  style: getTitleStyle(color: AppColors.primary),
                ),
                Gap(20),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Degree :',
                          style: getBodyStyle(color: AppColors.primary),
                        ),
                        Gap(10),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _degreename,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Enter Your degree',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your degree';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        Text('years :',
                            style: getBodyStyle(color: AppColors.primary)),
                        Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _startyear,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  labelText: 'From',
                                  labelStyle:
                                      getSmallStyle(color: AppColors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primary, width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  showYearPicker(context, _startyear);
                                },
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: TextFormField(
                                controller: _endyear,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  labelText: 'To',
                                  labelStyle:
                                      getSmallStyle(color: AppColors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primary, width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  showYearPicker(context, _endyear);
                                },
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Text('Inistutution name :',
                            style: getBodyStyle(color: AppColors.primary)),
                        Gap(10),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _uniname,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Enter name',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        Text('Inistutution country :',
                            style: getBodyStyle(color: AppColors.primary)),
                        Gap(10),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _unicountry,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Enter country name',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter country name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(30),
                        CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().usereducation(
                                    userid: user!.uid,
                                    degree: _degreename.text,
                                    starty: _startyear.text,
                                    endy: _endyear.text,
                                    inistitutionname: _uniname.text,
                                    inistitutioncountry: _unicountry.text,
                                    email: user!.email.toString());
                              }
                            },
                            text: 'next',
                            bgcolor: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 8.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
