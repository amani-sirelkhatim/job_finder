import 'package:flutter/material.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/features/jobSeeker/search/widgets/seerchResults.dart';
import 'package:job_finder/features/jopProvider/home/searchResult.dart';

class adminSearch extends StatelessWidget {
  const adminSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              push(context, searchresult());
            },
            child: Container(
              margin: EdgeInsets.all(5),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.search,
                color: AppColors.white,
              ),
            ),
          ),
          hintText: 'Search for a canidate',
          hintStyle: getBodyStyle(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(.5), width: 2.0),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
