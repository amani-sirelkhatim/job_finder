import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/core/utils/style.dart';

class canimages extends StatefulWidget {
  const canimages({super.key, required this.useremail});
  final String useremail;
  @override
  State<canimages> createState() => _canimagesState();
}

class _canimagesState extends State<canimages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userimages')
            .doc(widget.useremail)
            .collection('images')
            .snapshots(),
        builder: (context, snapshot) {
          print("Snapshot: $snapshot");
          if (!snapshot.hasData) {
            return Center(
              child: Text('Add images to your Accomplished work'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var userData = snapshot.data?.docs;
          print("Number of Documents: ${userData!.length}");
          return (userData.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: userData!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // You can adjust this value based on your requirements

                        crossAxisSpacing: 10,

                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        var documentData =
                            userData![index].data() as Map<String, dynamic>;
                        var imagePath = documentData['imagepath'];

                        return Container(
                          alignment: Alignment.bottomRight,
                          height: 400,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.white,
                              border: Border.all(color: AppColors.grey)),
                        );
                      }),
                )
              : Center(
                  child: Text(
                    '  no images',
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                );
        });
  }
}
