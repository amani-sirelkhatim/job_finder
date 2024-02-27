import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/auth/data/specs.dart';
import 'package:job_finder/features/jopProvider/home/speclization.dart';
import 'package:job_finder/features/jopProvider/home/widgets/speclizationmodle.dart';

class speclizations extends StatefulWidget {
  const speclizations({super.key});

  @override
  State<speclizations> createState() => _speclizationsState();
}

class _speclizationsState extends State<speclizations> {
  List<speclizationModle> spec = [
    speclizationModle(
        name: 'Software Development',
        color: AppColors.primary,
        image: 'assets/icons/software.png'),
    speclizationModle(
        name: 'web Development',
        color: Colors.greenAccent,
        image: 'assets/icons/html.png'),
    speclizationModle(
        name: 'Data Science and Analytics',
        color: Colors.orangeAccent,
        image: 'assets/icons/data-science.png'),
    speclizationModle(
        name: 'Cybersecurity',
        color: Colors.purple.withOpacity(.5),
        image: 'assets/icons/cyber-crime.png'),
    speclizationModle(
        name: 'Database Management',
        color: Colors.grey[800]!,
        image: 'assets/icons/data-processing.png'),
    speclizationModle(
        name: 'Quality Assurance',
        color: AppColors.grey,
        image: 'assets/icons/quality-assurance.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                push(context, speclization(spec: spec[index].name));
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                      color: spec[index].color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          spec[index].image,
                          width: 50,
                        ),
                      ),
                      Gap(10),
                      Text(spec[index].name,
                          textAlign: TextAlign.center,
                          style: getBodyStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
            );
          },
          separatorBuilder: (context, index) => Gap(2),
          itemCount: specs.length),
    );
  }
}
