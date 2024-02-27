import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/jobSeeker/profile/widgets/cvfullpage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class cv extends StatefulWidget {
  const cv({super.key});

  @override
  State<cv> createState() => _cvState();
}

class _cvState extends State<cv> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController skillcontroler = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  String? _filePath;
  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://job-hunt-ad8aa.appspot.com');

  Future<String?> uploadFileToFireStore(File file) async {
    try {
      Reference ref =
          _storage.ref().child('user/${_auth.currentUser!.uid}/cv/');

      // Determine the file type based on the file extension
      String fileType = file.path.split('.').last;
      String contentType;

      // Set the appropriate content type based on the file type
      switch (fileType) {
        case 'pdf':
          contentType = 'application/pdf';
          break;
        case 'doc':
        case 'docx':
          contentType = 'application/msword';
          break;
        // Add more cases for other file types if needed
        default:
          contentType = 'application/octet-stream'; // Default content type
          break;
      }

      SettableMetadata metadata = SettableMetadata(contentType: contentType);
      await ref.putFile(file, metadata);

      String url = await ref.getDownloadURL();
      addcvToFirestore(cvurl: url);

      return url;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> addcvToFirestore({
    required String cvurl,
  }) async {
    try {
      final CollectionReference imagecollection =
          FirebaseFirestore.instance.collection('usermaininfo');

      // Add the skill to Firestore with an automatically generated document ID
      await imagecollection.doc(user!.uid).set({
        'cv': cvurl,

        // Add more fields based on your Skill model
      }, SetOptions(merge: true));
      print(cvurl);
    } catch (e) {
      print(e);
    }

    // Optionally, you can clear the text field after adding the skill
  }

  Future<void> pickFile(BuildContext context) async {
    if (!mounted) {
      return;
    }
    await _getUser();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (mounted && result != null) {
        // Do something with the picked file
        setState(() {
          _filePath = result.files.first.path;
          file = File(_filePath!);
        });

        String? downloadUrl = await uploadFileToFireStore(file!);
        if (downloadUrl != null) {
          print('File uploaded successfully. Download URL: $downloadUrl');
        } else {
          print('Failed to upload file.');
        }

        print('Picked file: ${result.files.first.path}');
      } else {
        // User canceled the picker
        print('File picking canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(
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

            return ExpandablePanel(
                header: Row(
                  children: [
                    label(name: 'Cv', color: AppColors.black, size: 20),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: Icon(
                          userData!['cv'] == null ? Icons.add : Icons.edit,
                          color: AppColors.primary,
                        ))
                  ],
                ),
                collapsed: SizedBox(),
                expanded: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userData['cv'] != null && userData['cv'] is String
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
                                    child: SfPdfViewer.network(userData['cv']),
                                  )),
                            )
                          : Text(
                              ' please import your cv',
                              style: getBodyStyle(color: AppColors.primary),
                            ),
                      Gap(20),
                      userData['cv'] != null && userData['cv'] is String
                          ? CustomButton(
                              style: getSmallStyle(
                                  color: AppColors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              text: 'Full Page View',
                              bgcolor: AppColors.primary,
                              onTap: () {
                                push(context, fullpage());
                              },
                            )
                          : SizedBox()
                    ],
                  ),
                ));
          }),
    );
  }

  showAlertDialog(BuildContext context, {void Function()? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.white,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'import your CV',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Gap(20),
                    Gap(20),
                    CustomButton(
                      text: 'Add',
                      bgcolor: AppColors.primary,
                      onTap: () {
                        pickFile(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
