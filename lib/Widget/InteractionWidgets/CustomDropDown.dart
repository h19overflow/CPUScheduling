import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  CustomDropdown({
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Row(
          children: [
            Text(
              'Options',
              style: GoogleFonts.robotoMono(color: Colors.white),
            )
          ],
        ),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 2, 8, 37),
                Color.fromARGB(255, 18, 28, 101),
              ],
            ),
          ),
        ),
        style: GoogleFonts.robotoMono(color: Colors.white),
        value: widget.selectedValue,
      ),
    );
  }
}
