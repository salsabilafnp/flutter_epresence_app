import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String inputLabel;
  final String? initialValue;
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

  CustomTextField({
    super.key,
    this.controller,
    required this.inputLabel,
    this.initialValue,
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
      String? currentValue = controller?.text.isNotEmpty == true &&
              dropdownItems!.contains(controller?.text)
          ? controller?.text
          : initialValue != null && dropdownItems!.contains(initialValue!)
              ? Dictionary.mapTipe(initialValue!)
              : Dictionary.mapTipe(dropdownItems![0]);

      controller?.text = currentValue ?? '';

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: inputLabel,
            border: const OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isDense: true,
              value: currentValue,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller?.text = newValue;
                  if (onChanged != null) {
                    onChanged!(newValue);
                  }
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
      DateTime? initialDate;
      if (initialValue != null && initialValue!.isNotEmpty) {
        initialDate = DateFormat('yyyy-MM-d').parse(initialValue!);
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller
            ?..text = initialDate != null
                ? DateFormat('EEEE, d MMMM y').format(initialDate)
                : '',
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('EEEE, d MMMM y').format(pickedDate);
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
          controller: controller?..text = initialValue ?? '',
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
          controller: controller?..text = initialValue ?? '',
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
          controller: controller?..text = initialValue ?? '',
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
          controller: controller?..text = initialValue ?? '',
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
