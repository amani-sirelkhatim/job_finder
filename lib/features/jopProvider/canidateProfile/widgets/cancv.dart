import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/cvfullpage.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/widgets/cancvfullpage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class cancv extends StatefulWidget {
  const cancv({super.key, required this.useremail});
  final String useremail;
  @override
  State<cancv> createState() => _cancvState();
}

class _cancvState extends State<cancv> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('usermaininfo')
                .where('email', isEqualTo: widget.useremail)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }
              var userData = snapshot.data?.docs;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userData![0]['cv'] != null && userData[0]['cv'] is String
                      ? GestureDetector(
                          child: Container(
                              padding: EdgeInsets.all(1),
                              height: 150,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.grey),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SfPdfViewer.network(userData[0]['cv']),
                              )),
                        )
                      : Text(
                          'no cv',
                          style: getBodyStyle(color: AppColors.primary),
                        ),
                  Gap(20),
                  userData[0]['cv'] != null && userData[0]['cv'] is String
                      ? CustomButton(
                          style: getSmallStyle(
                              color: AppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          text: 'Full Page View',
                          bgcolor: AppColors.primary,
                          onTap: () {
                            push(
                                context,
                                cancvfullpage(
                                  useremail: widget.useremail,
                                ));
                          },
                        )
                      : SizedBox()
                ],
              );
            }));
  }
}
