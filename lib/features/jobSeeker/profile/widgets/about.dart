import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/dialogs.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_states.dart';

class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
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

  @override
  void dispose() {
    _updateabout.dispose();
    super.dispose();
  }

  final TextEditingController _aboutcon = TextEditingController();
  final TextEditingController _updateabout = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('usermaininfo')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }

              var userData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        label(
                            name: 'About Me', color: AppColors.black, size: 20),
                        Spacer(),
                        userData!['about'] == null
                            ? IconButton(
                                onPressed: () {
                                  showAlertDialog(context, type: 1);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: AppColors.primary,
                                ))
                            : IconButton(
                                onPressed: () {
                                  showAlertDialog(context, type: 2);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.primary,
                                )),
                      ],
                    ),
                    Gap(10),
                    if (userData?['about'] != null)
                      ExpandableText(
                        userData?['about'],
                        expandText: 'Read more',
                        collapseText: 'Read less',
                        maxLines: 2,
                        expanded: isExpanded,
                        onExpandedChanged: (bool expanded) {
                          setState(() {
                            isExpanded = expanded;
                          });
                        },
                        linkColor: AppColors.primary,
                      ),
                  ],
                ),
              );
            }));
  }

  showAlertDialog(BuildContext context,
      {void Function()? onTap, required int type}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.white,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 350,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: BlocListener<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is AboutSuccessState) {
                    print('Donnnneeeeeeee');
                  } else if (state is AboutErrorState) {
                    Navigator.pop(context);
                    showErrorDialog(context, state.error);
                  } else {
                    showLoadingDialog(context);
                  }
                },
                child: Form(
                    key: _formKey,
                    child: type == 1
                        ? Column(
                            children: [
                              Gap(20),
                              Text(
                                'About',
                                style: getTitleStyle(color: AppColors.primary),
                              ),
                              const SizedBox(height: 20),
                              Gap(20),
                              TextFormField(
                                textAlign: TextAlign.start,
                                maxLines: 5,
                                keyboardType: TextInputType.emailAddress,
                                controller: _aboutcon,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: Text('Bio'),
                                    labelStyle: getBodyStyle(),
                                    hintText: 'write about your self'),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter bio';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Gap(30),
                              CustomButton(
                                width: double.infinity,
                                text: 'done',
                                bgcolor: AppColors.primary,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().updateAboutUser(
                                        uid: user!.uid,
                                        uemail: user!.email.toString(),
                                        about: _aboutcon.text);
                                  }

                                  Navigator.pop(context);
                                },
                              )
                            ],
                          )
                        : StreamBuilder(
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
                              _updateabout.text = userData?['about'] != null
                                  ? userData!['about'].toString()
                                  : '';
                              return Column(
                                children: [
                                  Gap(20),
                                  Text(
                                    'About',
                                    style:
                                        getTitleStyle(color: AppColors.primary),
                                  ),
                                  const SizedBox(height: 20),
                                  Gap(20),
                                  TextFormField(
                                    textAlign: TextAlign.start,
                                    maxLines: 5,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _updateabout,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      label: Text('Bio'),
                                      labelStyle: getBodyStyle(),
                                      hintText: 'Write about yourself',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter bio';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  Gap(30),
                                  CustomButton(
                                    width: double.infinity,
                                    text: 'Update',
                                    bgcolor: AppColors.primary,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<AuthCubit>()
                                            .updateAboutUser(
                                                uid: user!.uid,
                                                uemail: user!.email.toString(),
                                                about: _updateabout.text);
                                      }
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          )),
              ),
            )
          ],
        );
      },
    );
  }
}
