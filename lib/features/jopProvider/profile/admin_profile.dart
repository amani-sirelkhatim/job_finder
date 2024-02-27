import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/features/jopProvider/profile/widgets/adminAbout.dart';
import 'package:job_finder/features/jopProvider/profile/widgets/adminpheader.dart';
import 'package:job_finder/features/jopProvider/profile/widgets/companyimages.dart';
import 'package:job_finder/features/jopProvider/profile/widgets/info.dart';

class adminProfile extends StatefulWidget {
  const adminProfile({super.key});

  @override
  State<adminProfile> createState() => _adminProfileState();
}

class _adminProfileState extends State<adminProfile> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AdminPHeader(),
            AdminAbout(),
            info(),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('adminmaininfo')
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
                  return userData!['type'] == 1 ? companyimages() : SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
