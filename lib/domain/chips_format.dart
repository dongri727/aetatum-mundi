import 'package:flutter/material.dart';

class ChipsFormat extends StatefulWidget {
  const ChipsFormat({Key? key}) : super(key: key);

  @override
  State<ChipsFormat> createState() => ChipsFormatState();
}

class ChipsFormatState extends State<ChipsFormat> {

  dynamic selectedData = List<Widget>;
  dynamic filters = List<Widget>;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(selectedData??""),
        selected: filters,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              if(!filters.contains(selectedData!)) {
                filters.add(selectedData!);
              }
            } else {
              filters.removeWhere((String term) {
                return term == selectedData!;
              });
            }
          });
        }
    );
  }
}