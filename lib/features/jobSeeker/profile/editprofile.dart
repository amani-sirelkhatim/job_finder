import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';
import 'package:job_finder/features/auth/presentation/view/job_seeker_reges/educationInfo1.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController birthdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: getTitleStyle(),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is UpdateSuccessState) {
            Navigator.pop(context);
            print('Donnnneeeeeeee');
          } else if (state is UpdateErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.error);
          } else {
            showLoadingDialog(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('usermaininfo')
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var userData = snapshot.data;
                  name.text = userData?['name'] != null
                      ? userData!['name'].toString()
                      : '';
                  email.text = userData?['email'] != null
                      ? userData!['email'].toString()
                      : '';
                  city.text = userData?['city'] != null
                      ? userData!['city'].toString()
                      : '';
                  phone.text = userData?['phone'] != null
                      ? userData!['phone'].toString()
                      : '';
                  birthdate.text = userData?['birthdate'] != null
                      ? userData!['birthdate'].toString()
                      : '';
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(50),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text('Name'),
                            labelStyle: getBodyStyle(),
                            hintText: 'Enter Full Name',
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
                        Gap(10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text('Email Address'),
                            labelStyle: getBodyStyle(),
                            hintText: 'Enter email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text('Mobile Number'),
                            labelStyle: getBodyStyle(),
                            hintText: 'Enter mobile number',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: AppColors.primary,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your mobile number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: city,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text('City'),
                            labelStyle: getBodyStyle(),
                            hintText: 'Enter city',
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
                        Gap(20),
                        TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          controller: birthdate,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              label: Text('Birth Date'),
                              labelStyle: getBodyStyle(),
                              hintText: 'Enter birthdate',
                              suffixIcon: GestureDetector(
                                  onTap: () async {
                                    var datePicked =
                                        await DatePicker.showSimpleDatePicker(
                                      context,
                                      // initialDate: DateTime(2020),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2090),
                                      dateFormat: "dd-MMMM-yyyy",
                                      locale: DateTimePickerLocale.en_us,
                                      looping: true,
                                    );

                                    final snackBar = SnackBar(
                                        content:
                                            Text("Date Picked $datePicked"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Icon(Icons.calendar_month,
                                      color: AppColors.primary))),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter birthdate';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(120),
                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().Updateuserprofile(
                                  uid: user!.uid,
                                  name: name.text,
                                  email: email.text,
                                  Address: city.text,
                                  phone: phone.text,
                                  birthdate: birthdate.text.substring(0, 11));
                            }
                          },
                          text: 'Update',
                          bgcolor: AppColors.primary,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
