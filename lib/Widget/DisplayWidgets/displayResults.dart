import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayResults extends StatelessWidget {
  const DisplayResults({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 2, 8, 37),
              Color.fromARGB(255, 18, 28, 101),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: const [
              BoxShadow(color: Colors.black45, blurRadius: 10)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          text,
          style: GoogleFonts.robotoMono(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
