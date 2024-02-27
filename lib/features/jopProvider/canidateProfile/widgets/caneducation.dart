import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

class caneducation extends StatefulWidget {
  const caneducation({super.key, required this.useremail});
  final String useremail;
  @override
  State<caneducation> createState() => _caneducationState();
}

class _caneducationState extends State<caneducation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120.0, left: 20, right: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usereducation')
              .doc(widget.useremail)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data;
            return userData != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Degree :',
                                style: getBodyStyle(),
                              ),
                              Gap(10),
                              Text(
                                userData['degree'],
                                style: getBodyStyle(color: AppColors.primary),
                              )
                            ],
                          ),
                          Gap(2),
                          Row(
                            children: [
                              Text(
                                'Uni Name :',
                                style: getBodyStyle(),
                              ),
                              Gap(15),
                              Text(
                                userData['inistitutionname'],
                                style: getBodyStyle(color: AppColors.primary),
                              )
                            ],
                          ),
                          Gap(2),
                          Row(
                            children: [
                              Text(
                                'From :',
                                style: getBodyStyle(),
                              ),
                              Gap(10),
                              Text(
                                userData['startY'],
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                              Gap(20),
                              Text(
                                'To :',
                                style: getBodyStyle(),
                              ),
                              Gap(10),
                              Text(
                                userData['endY'],
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                              Gap(20),
                              Icon(Icons.location_on_outlined),
                              Gap(10),
                              Text(
                                userData['inistututioncountry'],
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                          Gap(2),
                          Row(
                            children: [],
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          }),
    );
  }
}
