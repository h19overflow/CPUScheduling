import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevated extends StatelessWidget {
  const CustomElevated(
      {required this.iconData,
      super.key,
      required this.text,
      required this.function});

  final String text;
  final void Function() function;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        iconData,
        color: CupertinoColors.white,
      ),
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromARGB(254, 75, 101, 217),
          )),
      onPressed: function,
      label: Text(
        text,
        style: GoogleFonts.robotoMono(
            color: CupertinoColors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
