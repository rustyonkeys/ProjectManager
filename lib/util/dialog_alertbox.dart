import 'package:flutter/material.dart';
import 'package:taskmanager/util/MyButton.dart';  // Assuming this is a custom button widget

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  String? selectedPriority; //state variable to track the selected value
  @override
  Widget build(BuildContext context) {
    List<String> priority = ["High", "Low", "Medium"];

    return AlertDialog(
      backgroundColor: Colors.white,  // Set background color of the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,  // No border radius for the dialog
      ),
      content: SizedBox(
        width: 350,
        height: 200,// Set a fixed width for the dialog
        child: Column(  // Minimize space used by column
          children: [
                Expanded(  // Expand the TextField to fill available space
                  child: TextField(
                    controller: widget.controller,  // Use the controller for text input
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a new Task",
                    ),
                  ),
                ),
            DropdownButton(
              value: selectedPriority,
              hint: Text("select the priority"),
              onChanged: (String? newPriority) {
                setState(() {
                  selectedPriority = newPriority; //update the state
                });
              },
              items: priority.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value));
              }).toList(),
              isExpanded: true,
            ),
            SizedBox(height: 20),  // Add some spacing below the Row

            // Buttons: Save and Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align buttons to opposite ends
              children: [
                // Save Button
                ElevatedButton(
                  onPressed: widget.onSave,
                  child: Text("Save"),
                ),
                // Cancel Button
                ElevatedButton(
                  onPressed: widget.onCancel,
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
