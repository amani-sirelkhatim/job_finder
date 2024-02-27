import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';

showSentAlertDialog(BuildContext context,
    {String? ok,
    String? no,
    required String title,
    void Function()? onTap,
    required String alert,
    required String Subtiltle}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.grey,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.grey, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      Container(
                        width: 280,
                        height: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white),
                        child: Column(
                          children: [
                            Gap(50),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor:
                                      AppColors.primary.withOpacity(.2),
                                ),
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: AppColors.primary,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.white,
                                    child: Icon(
                                      Icons.done_outline_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Gap(30),
                            Text(
                              textAlign: TextAlign.center,
                              alert,
                              style: getTitleStyle(),
                            ),
                            Gap(15),
                            Text(
                              Subtiltle,
                              style: getBodyStyle(color: AppColors.grey),
                            ),
                            Gap(30),
                            CustomButton(
                                onTap: onTap,
                                text: ok,
                                bgcolor: AppColors.primary,
                                style: getBodyStyle(color: AppColors.white),
                                width: 200)
                          ],
                        ),
                      ),
                    if (no != null)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primary),
                          child: Text(
                            no,
                            style: getBodyStyle(color: AppColors.black),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
