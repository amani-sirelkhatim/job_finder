import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/features/auth/data/specs.dart';

class jobpost extends StatefulWidget {
  const jobpost(
      {super.key,
      required this.tilte,
      required this.subtilte,
      required this.image,
      required this.salary});
  final String tilte;
  final String subtilte;
  final String image;
  final String salary;

  @override
  State<jobpost> createState() => _jobpostState();
}

class _jobpostState extends State<jobpost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
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
              trailing: IconButton(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/denied.png',
                                      width: 100,
                                    ),
                                    Gap(20),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Are you sure you want to delete this job post ??',
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
                                            bgcolor: AppColors.lightgreen),
                                        Gap(20),
                                        CustomButton(
                                            text: 'delete', bgcolor: Colors.red)
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
                  ))),
          Gap(20),
          Wrap(
            spacing: 8,
            children: List.generate(specs.length, (index) {
              return Chip(
                labelPadding: EdgeInsets.all(2.0),
                label: Text(
                  specs[index],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black, fontSize: 14),
                ),

                backgroundColor: AppColors.primary.withOpacity(.1),
                elevation: 1,
                // padding: EdgeInsets.symmetric(
                //     horizontal: ),
              );
            }),
          ),
          Gap(20),
          Row(
            children: [
              Gap(10),
              Icon(Icons.location_off_outlined),
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
          Gap(20)
        ],
      ),
    );
  }
}
