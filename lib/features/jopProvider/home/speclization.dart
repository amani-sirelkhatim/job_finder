import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/canidateadmin.dart';
import 'package:job_finder/features/jopProvider/canidateProfile/canProfile.dart';

class speclization extends StatefulWidget {
  const speclization({super.key, required this.spec});
  final String spec;
  @override
  State<speclization> createState() => _speclizationState();
}

class _speclizationState extends State<speclization> {
  User? user;
  String? UserID;
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.spec),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('usermaininfo')
                  .where('speclization', isEqualTo: widget.spec)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Access your documents through snapshot.data.docs
                var maininfoDocs = snapshot.data?.docs;
                var userdata = snapshot.data!.docs;
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Result: ${maininfoDocs!.length}',
                          style: getSmallStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                    Gap(20),
                    SizedBox(
                      child: userdata.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var can = index < userdata.length
                                    ? userdata[index].data()
                                        as Map<String, dynamic>
                                    : null;
                                return can != null
                                    ? GestureDetector(
                                        onTap: () {
                                          push(
                                              context,
                                              canProfile(
                                                  useremail: can['email']));
                                        },
                                        child: canidateAdminSearch(
                                          name: can['name'] ?? '',
                                          jobtitle: can['jobtitle'] ?? '',
                                          image: can['image'] ?? '',
                                          about: can['about'] ?? '',
                                        ),
                                      )
                                    : SizedBox();
                              },
                              separatorBuilder: (context, index) => Gap(10),
                              itemCount: userdata.length)
                          : Center(
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Gap(150),
                                    Icon(Icons.search_off,
                                        color: AppColors.primary, size: 100),
                                    Gap(20),
                                    Text(
                                        'There is no Canidates in this speclization',
                                        style: getBodyStyle(
                                            color: AppColors.primary))
                                  ]),
                            ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
