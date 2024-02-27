import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/auth/data/specs.dart';

class canSkills extends StatefulWidget {
  const canSkills({super.key, required this.useremail});
  final String useremail;
  @override
  State<canSkills> createState() => _canSkillsState();
}

class _canSkillsState extends State<canSkills> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userskills')
              .doc(widget.useremail)
              .collection('skills')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data?.docs;
            return userData != null && userData.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20),
                      Wrap(
                        spacing: 8,
                        children: List.generate(userData.length, (index) {
                          var skill = index < userData.length
                              ? userData[index].data() as Map<String, dynamic>
                              : null;
                          return Chip(
                            labelPadding: EdgeInsets.all(2.0),
                            label: Text(
                              skill?['name'] ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black, fontSize: 14),
                            ),

                            backgroundColor: AppColors.primary.withOpacity(.1),
                            elevation: 1,
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: ),
                          );
                        }),
                      ),
                    ],
                  )
                : SizedBox();
          }),
    );
  }
}
