import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/util/logicheatmap.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left_outlined, size: 40),
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Completion Heatmap",
            style: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // ✅ Common Heatmap Widget
          Expanded(child: HeatmapWidget()),
        ],
      ),
    );
  }
}
