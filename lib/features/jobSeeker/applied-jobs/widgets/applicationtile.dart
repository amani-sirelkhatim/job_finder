import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';

class applicationTile extends StatefulWidget {
  const applicationTile(
      {super.key,
      required this.withdowl,
      required this.tilte,
      required this.subtilte,
      required this.image,
      required this.salary});
  final String tilte;
  final String subtilte;
  final String image;
  final String salary;
  final int withdowl;
  @override
  State<applicationTile> createState() => _applicationTileState();
}

class _applicationTileState extends State<applicationTile> {
  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
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
              widget.tilte,
              style: getBodyStyle(),
            ),
            subtitle: Text(
              widget.subtilte,
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
              Gap(10),
              Icon(Icons.location_on_outlined),
              Gap(15),
              Text(
                'Calafonia/Usa',
                style: getBodyStyle(color: AppColors.black),
              ),
              Spacer(),
              Text(
                '${widget.salary}/month',
                style: getBodyStyle(color: AppColors.black),
              ),
              Gap(15)
            ],
          ),
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
                                            'Are you sure you want to withdow your job application??',
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
                                                  text: 'withdow',
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
