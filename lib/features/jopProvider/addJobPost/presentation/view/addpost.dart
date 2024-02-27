import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';
import 'package:job_finder/core/widgets/custom_button.dart';
import 'package:job_finder/core/widgets/label.dart';
import 'package:job_finder/features/auth/data/specs.dart';
import 'package:job_finder/features/jopProvider/addJobPost/presentation/view/about.dart';
import 'package:job_finder/features/jopProvider/addJobPost/data/title.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  int defaultChoiceIndex2 = -1;
  String speclization = specs[0];
  List<String>? selectedList;

  @override
  void initState() {
    super.initState();
    updateJobTitles();
  }

  void updateJobTitles() {
    selectedList = title(speclization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Post a New Job',
          style: getTitleStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                label(
                    name: 'speclization:', color: AppColors.primary, size: 20),
              ],
            ),
            SizedBox(
                height: 50,
                width: 300,
                child: DropdownButtonFormField<String>(
                    dropdownColor: Color(0xffCDE9ED),
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid, color: AppColors.black),
                      ),
                    ),
                    value: speclization.isNotEmpty ? speclization : null,

                    // hint: Text('اختر تخصصك'),
                    items: specs.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        speclization = value!;
                        updateJobTitles();
                      });
                    })),
            Gap(20),
            Row(
              children: [
                label(name: 'Job Tiltle:', color: AppColors.primary, size: 20),
              ],
            ),
            Gap(10),
            Wrap(
              spacing: 8,
              children: List.generate(selectedList?.length ?? 0, (index) {
                return ChoiceChip(
                  labelPadding: EdgeInsets.all(2.0),
                  label: Text(
                    selectedList?[index] ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black, fontSize: 14),
                  ),
                  selected: defaultChoiceIndex2 == index,
                  selectedColor: AppColors.primary,
                  onSelected: (value) {
                    setState(() {
                      defaultChoiceIndex2 = -1;
                      defaultChoiceIndex2 = value ? index : defaultChoiceIndex2;
                      print(index);
                    });
                  },
                  backgroundColor: AppColors.primary.withOpacity(.1),

                  // backgroundColor: color,
                  elevation: 1,
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: ),
                );
              }),
            ),
            Gap(20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          text: 'Next',
          bgcolor: AppColors.primary,
          onTap: () {
            push(context, About());
          },
        ),
      ),
    );
  }
}
