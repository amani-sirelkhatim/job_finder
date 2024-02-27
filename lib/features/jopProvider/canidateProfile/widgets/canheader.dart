import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/auth/presentation/view/login.dart';
import 'package:recase/recase.dart';

class canHeader extends StatefulWidget {
  const canHeader({
    super.key,
    required this.useremail,
  });
  final String useremail;
  @override
  State<canHeader> createState() => _canHeaderState();
}

class _canHeaderState extends State<canHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(.9),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder(
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
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: AppColors.lightgreen,
                                    border: Border.all(
                                        color: AppColors.black, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: userData != null && userData.isNotEmpty
                                    ? Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  userData[0]['coverimage'] ??
                                                      '',
                                                  height: 149,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )),
                                          ])
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'no cover image',
                                            style: getBodyStyle(
                                                color: AppColors.white),
                                          )
                                        ],
                                      ),
                              ),
                              Positioned(
                                top: 80,
                                left: 20,
                                child: Stack(children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColors.black,
                                      child: CircleAvatar(
                                          radius: 47,
                                          backgroundColor: AppColors.lightgreen,
                                          backgroundImage: userData != null &&
                                                  userData.isNotEmpty
                                              ? NetworkImage(userData[0]
                                                          ['image'] ??
                                                      '' as String)
                                                  as ImageProvider<Object>
                                              : AssetImage(
                                                      'assets/icons/profile.png')
                                                  as ImageProvider<Object>)),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ReCase(userData![0]['name']).titleCase ??
                                        '',
                                    style: getTitleStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userData[0]['email'] ?? '',
                                    style: getSmallStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  //  push(context, editAdmin());
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: AppColors.black, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.message,
                                      color: AppColors.white,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
