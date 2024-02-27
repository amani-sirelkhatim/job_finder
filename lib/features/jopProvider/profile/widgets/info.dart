import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
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

  _launchURL(String url) async {
    Uri _url = Uri.parse(url);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Future<void> deleteDocument(
      {required String link, required String url}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('adminlinks')
          .doc(user!.email) // Replace with your user ID
          .collection('links')
          .where('name', isEqualTo: link)
          .where('url', isEqualTo: url)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController linkcontroler = TextEditingController();
  final TextEditingController urlcontroler = TextEditingController();
  int skillCounter = 1;
  Future<void> addLinkToFirestore(String link, String url) async {
    final CollectionReference linkCollection = FirebaseFirestore.instance
        .collection('adminlinks')
        .doc(user!.email)
        .collection('links');

    // Add the skill to Firestore with an automatically generated document ID
    await linkCollection.add({
      'name': link,
      'url': url,
      // Add more fields based on your Skill model
    });

    // Optionally, you can clear the text field after adding the skill
    linkcontroler.clear();
    urlcontroler.clear();
  }

  int defaultChoiceIndex1 = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('adminlinks')
              .doc(user?.email)
              .collection('links')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data?.docs;
            var filteredUserData = userData!.where((doc) {
              return doc.id.isNotEmpty && doc.data()?.isNotEmpty == true;
            }).toList();
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpandablePanel(
                      header: Row(
                        children: [
                          label(
                              name: 'Links', color: AppColors.black, size: 20),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                showAlertDialog(context);
                              },
                              icon: Icon(
                                Icons.add_outlined,
                                color: AppColors.primary,
                              ))
                        ],
                      ),
                      collapsed: SizedBox(),
                      expanded:
                          (userData != null &&
                                  userData.isNotEmpty &&
                                  filteredUserData.isNotEmpty)
                              ? SizedBox(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var link = userData[index].data()
                                            as Map<String, dynamic>;
                                        return link['name'] != null
                                            ? Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColors.primary
                                                        .withOpacity(.1)),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _launchURL(link['url']);
                                                      },
                                                      child: Text(
                                                        ReCase(link['name'])
                                                            .titleCase,
                                                        style: getBodyStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return SimpleDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .white,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          20.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          const Gap(
                                                                              20),
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            'Are you sure you want to Delete this Link??',
                                                                            style:
                                                                                getTitleStyle(fontWeight: FontWeight.normal),
                                                                          ),
                                                                          Gap(30),
                                                                          Row(
                                                                            children: [
                                                                              CustomButton(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  text: 'cancel',
                                                                                  bgcolor: AppColors.lightgreen),
                                                                              const Gap(20),
                                                                              CustomButton(
                                                                                  onTap: () {
                                                                                    deleteDocument(link: link['name'], url: link['url']);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  text: 'Delete',
                                                                                  bgcolor: Colors.red)
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 15,
                                                          color: Colors.red
                                                              .withOpacity(.8),
                                                        ))
                                                  ],
                                                )
                                                // child: ,
                                                )
                                            : SizedBox();
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Gap(10),
                                      itemCount: userData.length),
                                )
                              : Center(
                                  child: Text(
                                    ' please add your links',
                                    style:
                                        getBodyStyle(color: AppColors.primary),
                                  ),
                                ),
                    ),
                  ]),
            );
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
              height: 310,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'New Link',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: linkcontroler,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Link'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your link';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(10),
                    TextFormField(
                      keyboardType: TextInputType.url,
                      controller: urlcontroler,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text('Url'),
                        labelStyle: getBodyStyle(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your url';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(20),
                    CustomButton(
                      text: 'Add',
                      bgcolor: AppColors.primary,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addLinkToFirestore(
                              linkcontroler.text, urlcontroler.text);
                          Navigator.pop(context);
                        }
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
