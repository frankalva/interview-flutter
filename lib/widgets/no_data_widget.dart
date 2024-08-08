import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 95, color: Color.fromARGB(255, 81, 81, 81)),
            const SizedBox(height: 20),
            Text(
              'No data Found',
              style: GoogleFonts.nanumGothic(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 82, 77, 77),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Please add the city to track it's weather",
              style: GoogleFonts.nanumGothic(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}