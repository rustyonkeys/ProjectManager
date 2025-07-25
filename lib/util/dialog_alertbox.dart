import 'package:flutter/material.dart';
import 'package:taskmanager/util/MyButton.dart';  // Assuming this is a custom button widget
import 'package:taskmanager/util/category.dart';  // Category dropdown widget

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
  String? selectedOption;  // Holds the selected option for the dropdown

  // Update the selected priority option
  void onCategoryChanged(String? newPriority) {
    setState(() {
      selectedOption = newPriority;  // Update the selected option when the user selects a new priority
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],  // Set background color of the dialog
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

                Category(
                  selectedItem: selectedOption,  // Pass the selected option for the dropdown
                  onChanged: onCategoryChanged,  // Notify the parent when the selection changes
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
