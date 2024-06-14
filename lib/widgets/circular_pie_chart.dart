import 'package:flutter/material.dart';

class CircularPieChart extends StatelessWidget {
  final double percentage; // The percentage of the pie chart to fill (0 to 1)
  final double size; // The size of the pie chart widget
  final int totalScore; // The total score to display inside the pie chart

  CircularPieChart({
    required this.percentage,
    required this.size,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    final double strokeWidth = size / 10; // Define the thickness of the pie chart

    // Calculate the angle in degrees to fill based on the percentage
    final double angle = 360 * percentage;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CircularPainter(angle, strokeWidth),
        child: Center(
          child: Text(
            totalScore.toString()+'\n  ₹', // Display the total score
            style: TextStyle(
              fontSize: size / 5, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
              color: Colors.green, // Set the text color to green
            ),
          ),
        ),
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double angle;
  final double strokeWidth;

  CircularPainter(this.angle, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green // Set the green color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - strokeWidth / 2,
    );

    // Draw a partial circle representing the percentage
    canvas.drawArc(rect, -90 * (3.14159265359 / 180), angle * (3.14159265359 / 180), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
