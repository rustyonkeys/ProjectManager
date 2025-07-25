import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  const Category({
    super.key,
    required this.selectedItem,
  required this.onChanged});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    List<String> priority = ['High', 'Medium' ,'Low'];
    // String? selectedItem; since we are using widget.selectedItem priority is passed down as selectedItem in here so this file is child file and dialog_alertbox becomes parent

    return DropdownButton<String>(
      hint: Text("Select the priority"),
        value: widget.selectedItem,
        onChanged: (String? newValue)
        {widget.onChanged(newValue);}, //Notify the parent of the change
    items: priority.map<DropdownMenuItem<String>>((String value){
      return DropdownMenuItem<String>(
          value: value,
          child: Text(value));
    }).toList(),
      isExpanded: true,
    );
  }
}
