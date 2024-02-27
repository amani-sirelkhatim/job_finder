import 'package:flutter/material.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jobSeeker/home/presentation/view/popularSeeAll.dart';

class popularJobs extends StatefulWidget {
  const popularJobs({super.key});

  @override
  State<popularJobs> createState() => _popularJobsState();
}

class _popularJobsState extends State<popularJobs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Popular Jobs',
                style: getTitleStyle(
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    push(context, popularSeeAll());
                  },
                  child: Text(
                    'See All',
                    style: getSmallStyle(color: AppColors.primary),
                  ))
            ],
          ),
          SizedBox(
            height: 150,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 75,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GridTile(
                      child: Container(
                    height: 50, width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary.withOpacity(.1)),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/google.png',
                        width: 30,
                      ),
                      title: Text(
                        'UI Designer',
                        style: getBodyStyle(),
                      ),
                      subtitle: Text(
                        'Google / Calafonia USA',
                        style:
                            getSmallStyle(color: AppColors.grey, fontSize: 12),
                      ),
                      trailing: Image.asset(
                        'assets/icons/more.png',
                        width: 20,
                      ),
                    ),
                    // child: ,
                  ));
                }),
          )
        ],
      ),
    );
  }
}
