import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/auth/presentation/view/login.dart';
import 'package:job_finder/features/jobSeeker/profile/editprofile.dart';
import 'package:job_finder/features/jopProvider/profile/widgets/edit_Admin.dart';
import 'package:recase/recase.dart';

class AdminPHeader extends StatefulWidget {
  const AdminPHeader({super.key});

  @override
  State<AdminPHeader> createState() => _AdminPHeaderState();
}

class _AdminPHeaderState extends State<AdminPHeader> {
  User? user;
  String? UserID;
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  late String image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://job-hunt-ad8aa.appspot.com');
  Future<String> uploadImageToFireStore(File image, int type) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String folderName = type == 0 ? 'profile' : 'cover';
      String imagePath = '$folderName/${_auth.currentUser!.uid}/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      await addImageToFirestore(imageUrl: url, type: type);

      return url;
    } catch (e) {
      print('Error during image upload to Firestore: $e');
      return '';
    }
  }

  Future<void> addImageToFirestore(
      {required String imageUrl, required int type}) async {
    try {
      String fieldName = type == 0 ? 'image' : 'coverimage';

      final CollectionReference imageCollection =
          FirebaseFirestore.instance.collection('adminmaininfo');

      await imageCollection.doc(user!.uid).set({
        fieldName: imageUrl,
      }, SetOptions(merge: true));

      print('Image added to Firestore: $imageUrl');
    } catch (e) {
      print('Error adding image to Firestore: $e');
    }
  }

  Future<void> UploadFromGallery({required int type}) async {
    await _getUser();

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          file = File(pickedFile.path);
        });
      }

      final imageUrl = await uploadImageToFireStore(file!, type);
      print('Image uploaded successfully: $imageUrl');

      // Update the UI or perform any other actions as needed
      setState(() {
        // Update your state if needed
      });
    } catch (e) {
      print('Error during image upload: $e');
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 317,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.black.withOpacity(.9),
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
                      .collection('adminmaininfo')
                      .doc(user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var userData = snapshot.data;
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
                                    border: Border.all(color: AppColors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: userData!['coverimage'] != null
                                    ? Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  userData!['coverimage'],
                                                  height: 149,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  UploadFromGallery(type: 1);
                                                },
                                                icon: Icon(
                                                    Icons.camera_alt_rounded,
                                                    color: AppColors.white))
                                          ])
                                    : GestureDetector(
                                        onTap: () {
                                          UploadFromGallery(type: 1);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt_rounded,
                                                color: AppColors.white),
                                            Gap(5),
                                            Text(
                                              'Add cover image',
                                              style: getBodyStyle(
                                                  color: AppColors.white),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Positioned(
                                top: 80,
                                left: 20,
                                child: Stack(children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColors.white,
                                      child: CircleAvatar(
                                          radius: 47,
                                          backgroundColor: AppColors.lightgreen,
                                          backgroundImage: userData!['image'] ==
                                                  null
                                              ? AssetImage(
                                                      'assets/icons/profile.png')
                                                  as ImageProvider<Object>
                                              : NetworkImage(userData['image']
                                                      as String)
                                                  as ImageProvider<Object>)),
                                  Positioned(
                                    left: 60,
                                    top: 68,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                          onPressed: () {
                                            UploadFromGallery(type: 0);
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            color: AppColors.white,
                                            size: 20,
                                          )),
                                    ),
                                  )
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
                                    ReCase(userData?['name']).titleCase,
                                    style: getTitleStyle(
                                        color: AppColors.white.withOpacity(.8)),
                                  ),
                                  Text(
                                    userData!['email'],
                                    style: getSmallStyle(
                                        color: AppColors.white.withOpacity(.8)),
                                  )
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  push(context, editAdmin());
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: AppColors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.edit_sharp,
                                      color: AppColors.white,
                                    )),
                              ),
                              Gap(10),
                              GestureDetector(
                                  onTap: () {
                                    pushWithReplacment(context, login(type: 0));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        'assets/icons/exit.png',
                                      ))),
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
