import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

void showYearPicker(
    BuildContext context, TextEditingController yearController) async {
  final DateTime currentDate = DateTime.now();
  final int currentYear = currentDate.year;

  final List<int> years = List.generate(50, (index) => currentYear - index);

  int? selectedYear = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Year'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: years.length,
            itemBuilder: (BuildContext context, int index) {
              final year = years[index];
              return ListTile(
                title: Text(year.toString()),
                onTap: () {
                  Navigator.of(context).pop(year);
                },
              );
            },
          ),
        ),
      );
    },
  );

  if (selectedYear != null) {
    yearController.text = selectedYear.toString();
  }
}
