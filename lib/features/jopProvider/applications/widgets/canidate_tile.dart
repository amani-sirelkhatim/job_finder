import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';

class canidateTile extends StatefulWidget {
  const canidateTile(
      {super.key,
      required this.name,
      required this.jobtitle,
      required this.image,
      required this.applicationLetter,
      required this.withdowl,
      required this.job});
  final String name;
  final String jobtitle;
  final String image;
  final String applicationLetter;
  final int withdowl;
  final String job;
  @override
  State<canidateTile> createState() => _canidateTileState();
}

class _canidateTileState extends State<canidateTile> {
  bool isExpanded = false;
  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary.withOpacity(.1)),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              widget.image,
              width: 30,
            ),
            title: Text(
              widget.name,
              style: getBodyStyle(),
            ),
            subtitle: Text(
              widget.jobtitle,
              style: getSmallStyle(color: AppColors.grey, fontSize: 12),
            ),
            trailing: GestureDetector(
              onTap: toggleSaved,
              child: issaved
                  ? Image.asset(
                      'assets/icons/unsave.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/icons/bookmark.png',
                      width: 20,
                    ),
            ),
          ),
          Gap(10),
          Row(
            children: [
              label(
                  name: 'Job:',
                  color: AppColors.primary.withOpacity(.5),
                  size: 14),
              Gap(10),
              Text(
                widget.job,
                style: getBodyStyle(fontSize: 13),
              )
            ],
          ),
          Gap(10),
          Row(
            children: [
              label(
                  name: 'Application Letter:',
                  color: AppColors.primary.withOpacity(.5),
                  size: 14),
            ],
          ),
          Gap(10),
          ExpandableText(
            widget.applicationLetter,
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
          widget.withdowl == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: AppColors.white,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/denied.png',
                                            width: 100,
                                          ),
                                          Gap(20),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'Are you sure you want to Reject yhis Canidate??',
                                            style: getTitleStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Gap(30),
                                          Row(
                                            children: [
                                              CustomButton(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: 'cancel',
                                                  bgcolor:
                                                      AppColors.lightgreen),
                                              Gap(20),
                                              CustomButton(
                                                  text: 'Reject',
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
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ))
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
