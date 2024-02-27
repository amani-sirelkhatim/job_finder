import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:recase/recase.dart';

class experiancetile extends StatefulWidget {
  const experiancetile({
    super.key,
    required this.job,
    required this.company,
    required this.location,
    required this.duration,
    required this.type,
  });
  final int type;
  final String job;
  final String company;
  final String location;
  final String duration;

  @override
  State<experiancetile> createState() => _experiancetileState();
}

class _experiancetileState extends State<experiancetile> {
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

  Future<void> deleteDocument() async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userexperiance')
          .doc(user!.email)
          .collection('experiance')
          .where('job', isEqualTo: widget.job)
          .where('company', isEqualTo: widget.company)
          .where('location', isEqualTo: widget.location)
          .where('duration', isEqualTo: widget.duration)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/decision-making.png',
            width: 40,
          ),
          Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ReCase(widget.job).titleCase,
                style: getTitleStyle(color: AppColors.black.withOpacity(.8)),
              ),
              Text(
                '${ReCase(widget.company).titleCase} / ${ReCase(widget.location).titleCase}',
                style: getSmallStyle(color: AppColors.black.withOpacity(.8)),
              ),
              Text(
                ReCase(widget.duration).titleCase,
                style: getSmallStyle(color: AppColors.black.withOpacity(.8)),
              )
            ],
          ),
          Spacer(),
          widget.type == 0
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: AppColors.white,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Gap(20),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Are you sure you want to Delete your job Experiance??',
                                      style: getTitleStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Gap(30),
                                    Row(
                                      children: [
                                        CustomButton(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            text: 'cancel',
                                            bgcolor: AppColors.lightgreen),
                                        Gap(20),
                                        CustomButton(
                                            onTap: () {
                                              deleteDocument();
                                              Navigator.pop(context);
                                            },
                                            text: 'Delete',
                                            bgcolor: Colors.red)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.delete,
                        size: 15,
                        color: Colors.red.withOpacity(.5),
                      )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
