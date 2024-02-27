// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:job_finder/core/utils/colors.dart';
// import 'package:job_finder/core/utils/style.dart';
// import 'package:job_finder/core/widgets/custom_button.dart';
// import 'package:job_finder/features/auth/data/linksmodle.dart';

// TextEditingController titlecon = TextEditingController();
// TextEditingController urlcon = TextEditingController();
// List<linksmodel> links = [];
// showAlertDialog(BuildContext context,
//     {String? ok, String? no, void Function()? onTap}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return SimpleDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         backgroundColor: AppColors.grey,
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             height: 300,
//             width: 600,
//             decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(20)),
//             child: Column(
//               children: [
//                 Text(
//                   'Add a link to your profile',
//                   style: getTitleStyle(color: AppColors.primary),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   //controller: _nameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     label: Text('website title'),
//                     labelStyle: getBodyStyle(),
//                   ),
//                   textInputAction: TextInputAction.next,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please the title';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 Gap(20),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   //controller: _nameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     label: Text('website url'),
//                     labelStyle: getBodyStyle(),
//                     hintText: 'Enter Your Name',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your name';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 Gap(20),
//                 CustomButton(
//                   text: 'Add',
//                   bgcolor: AppColors.primary,
//                   onTap: () {
//                     List<linksmodel> links = [
//                       linksmodel(title: titlecon, url: urlcon)
//                     ];

//                     print('done');
//                   },
//                 )
//               ],
//             ),
//           )
//         ],
//       );
//     },
//   );
// }
