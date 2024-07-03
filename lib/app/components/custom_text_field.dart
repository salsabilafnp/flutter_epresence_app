import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String inputLabel;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool autoFocus;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final IconData? icon;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final bool isDate;
  final bool isNumber;
  final bool isTextarea;
  final bool isFile;

  const CustomTextField({
    super.key,
    this.controller,
    required this.inputLabel,
    this.onChanged,
    this.onTap,
    this.autoFocus = false,
    this.obscureText = false,
    this.readOnly = false,
    this.hintText,
    this.icon,
    this.isDropdown = false,
    this.dropdownItems,
    this.isDate = false,
    this.isNumber = false,
    this.isTextarea = false,
    this.isFile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isDropdown && dropdownItems != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true, // Mengurangi tinggi dropdown
              value: controller?.text.isEmpty ?? true ? null : controller?.text,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller?.text = newValue;
                  if (onChanged != null) onChanged!(newValue);
                }
              },
              items:
                  dropdownItems!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      );
    } else if (isDate) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('EEEE, d MMMM y', 'id_ID').format(pickedDate);
              controller?.text = formattedDate;
              if (onChanged != null) onChanged!(formattedDate);
            }
          },
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      );
    } else if (isNumber) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      );
    } else if (isTextarea) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          maxLines: 5,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
          ),
        ),
      );
    } else if (isFile) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              String fileName = result.files.single.name;
              controller?.text = fileName;
              if (onChanged != null) onChanged!(fileName);
            }
          },
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          autofocus: autoFocus,
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: onTap,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: inputLabel,
            hintText: hintText,
            border: const OutlineInputBorder(),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      );
    }
  }
}
