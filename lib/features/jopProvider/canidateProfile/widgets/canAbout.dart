import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/widgets/label.dart';

class canAbout extends StatefulWidget {
  const canAbout({super.key, required this.useremail});
  final String useremail;
  @override
  State<canAbout> createState() => _canAboutState();
}

class _canAboutState extends State<canAbout> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usermaininfo')
              .where('email', isEqualTo: widget.useremail)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data?.docs;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userData![0]['about'] != null
                    ? Column(
                        children: [
                          Row(
                            children: [
                              label(
                                  name: 'About',
                                  color: AppColors.black,
                                  size: 20),
                            ],
                          ),
                          ExpandableText(
                            userData[0]['about'] ?? '',
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
                          Gap(10),
                        ],
                      )
                    : SizedBox(),
              ],
            );
          }),
    );
  }
}
