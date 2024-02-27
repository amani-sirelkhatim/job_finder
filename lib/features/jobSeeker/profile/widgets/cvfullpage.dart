import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class fullpage extends StatefulWidget {
  const fullpage({super.key});

  @override
  State<fullpage> createState() => _fullpageState();
}

class _fullpageState extends State<fullpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cv',
          style: getTitleStyle(),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usermaininfo')
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
            if (userData == null) {
              return Center(
                child: Text('CV not found in the document'),
              );
            }
            return Container(
              child: SfPdfViewer.network(userData['cv']),
            );
          }),
    );
  }
}
