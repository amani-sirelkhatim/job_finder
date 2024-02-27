import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/experiancetile.dart';

class experiance extends StatefulWidget {
  const experiance({super.key});

  @override
  State<experiance> createState() => _experianceState();
}

class _experianceState extends State<experiance> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController companycon = TextEditingController();
  final TextEditingController skillcontroler = TextEditingController();
  final TextEditingController jobcon = TextEditingController();
  final TextEditingController locationcon = TextEditingController();
  final TextEditingController durationcon = TextEditingController();
  Future<void> addExperianceToFirestore(
      {required String jobtitle,
      required String companyname,
      required String location,
      required String duration}) async {
    final CollectionReference ExperianceCollection = FirebaseFirestore.instance
        .collection('userexperiance')
        .doc(user!.email)
        .collection('experiance');

    // Add the skill to Firestore with an automatically generated document ID
    await ExperianceCollection.add({
      'job': jobtitle,
      'company': companyname,
      'location': location,
      'duration': duration

      // Add more fields based on your Skill model
    });

    // Optionally, you can clear the text field after adding the skill

    companycon.clear();
    jobcon.clear();
    locationcon.clear();
    durationcon.clear();
  }

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userexperiance')
              .doc(user?.email)
              .collection('experiance')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var userData = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandablePanel(
                    header: Row(
                      children: [
                        label(
                            name: 'Experiance',
                            color: AppColors.black,
                            size: 20),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            icon: Icon(
                              Icons.add_outlined,
                              color: AppColors.primary,
                            ))
                      ],
                    ),
                    collapsed: SizedBox(),
                    expanded: Column(
                      children: [
                        if (userData != null && userData.isNotEmpty)
                          Column(
                            children: [
                              SizedBox(
                                child: (userData != null && userData.isNotEmpty)
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var experiance = userData != null &&
                                                  index < userData.length
                                              ? userData[index].data()
                                                  as Map<String, dynamic>
                                              : null;

                                          return experiancetile(
                                            type: 0,
                                            job: experiance != null
                                                ? experiance['job'].toString()
                                                : '',
                                            company: experiance != null
                                                ? experiance['company']
                                                    .toString()
                                                : '',
                                            location: experiance != null
                                                ? experiance['location']
                                                    .toString()
                                                : '',
                                            duration: experiance != null
                                                ? experiance['duration']
                                                    .toString()
                                                : '',
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Gap(20),
                                        itemCount: userData.length)
                                    : Center(
                                        child: Text(
                                          ' please add your experiances',
                                          style: getBodyStyle(
                                              color: AppColors.primary),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        if (userData == null || userData.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                child: Text(
                              'Add Your Work Experiances',
                              style: getBodyStyle(color: AppColors.primary),
                            )),
                          ),
                      ],
                    ))
              ],
            );
          }),
    );
  }

  showAlertDialog(BuildContext context, {void Function()? onTap}) {
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
              height: 500,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(20),
                    Text(
                      'New Experiance',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: companycon,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Company Name'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter company name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(15),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: jobcon,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Job Title'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please job title';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(15),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: locationcon,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Location'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter location';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(15),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: durationcon,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Duration'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter duration';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(30),
                    CustomButton(
                      width: double.infinity,
                      text: 'Add',
                      bgcolor: AppColors.primary,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addExperianceToFirestore(
                              jobtitle: jobcon.text,
                              companyname: companycon.text,
                              location: locationcon.text,
                              duration: durationcon.text);
                        }
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
