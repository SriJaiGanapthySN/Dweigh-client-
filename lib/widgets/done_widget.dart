import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoneWidget extends StatelessWidget {
  const DoneWidget(
      {super.key,
      required this.asset,
      required this.height,
      required this.width});

  final String asset;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0F8F5),
      body: Center(
        child: Column(children: [
          Image.asset(
            asset,
            height: height,
            width: width,
          ),
          Text(
            "Service  Booked Successfully",
            style: GoogleFonts.lemon(
              fontSize: 36,
              color: const Color(0xFF034C8D),
            ),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
