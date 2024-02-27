import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';

class jobetile extends StatefulWidget {
  const jobetile(
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
  State<jobetile> createState() => _jobetileState();
}

class _jobetileState extends State<jobetile> {
  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
          Row(
            children: [
              Gap(20),
              CustomButton(
                text: 'text',
                bgcolor: AppColors.primary,
                width: 60,
              ),
              Gap(15),
              CustomButton(
                text: 'text',
                bgcolor: AppColors.primary,
                width: 60,
              ),
              Gap(15),
              CustomButton(
                text: 'text',
                bgcolor: AppColors.primary,
                width: 60,
              ),
            ],
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
        ],
      ),
    );
  }
}
