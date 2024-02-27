import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/experiancetile.dart';

class canExperiance extends StatefulWidget {
  const canExperiance({super.key, required this.useremail});
  final String useremail;
  @override
  State<canExperiance> createState() => _canExperianceState();
}

class _canExperianceState extends State<canExperiance> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userexperiance')
              .doc(widget.useremail)
              .collection('experiance')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data?.docs;
            return userData != null && userData.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var experiance = index < userData.length
                                    ? userData[index].data()
                                        as Map<String, dynamic>
                                    : null;
                                return experiancetile(
                                  type: 1,
                                  job: experiance != null
                                      ? experiance['job'].toString()
                                      : '',
                                  company: experiance != null
                                      ? experiance['company'].toString()
                                      : '',
                                  location: experiance != null
                                      ? experiance['location'].toString()
                                      : '',
                                  duration: experiance != null
                                      ? experiance['duration'].toString()
                                      : '',
                                );
                              },
                              separatorBuilder: (context, index) => Gap(20),
                              itemCount: userData.length),
                        )
                      ],
                    ),
                  )
                : SizedBox();
          }),
    );
  }
}
