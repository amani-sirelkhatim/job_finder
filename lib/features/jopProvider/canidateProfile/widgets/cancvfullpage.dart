import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class cancvfullpage extends StatefulWidget {
  const cancvfullpage({super.key, required this.useremail});
  final String useremail;
  @override
  State<cancvfullpage> createState() => _cancvfullpageState();
}

class _cancvfullpageState extends State<cancvfullpage> {
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
            if (userData == null) {
              return Center(
                child: Text('CV not found in the document'),
              );
            }
            return userData![0]['cv'] != null && userData[0]['cv'] is String
                ? Container(
                    child: SfPdfViewer.network(userData[0]['cv']),
                  )
                : SizedBox();
          }),
    );
  }
}
