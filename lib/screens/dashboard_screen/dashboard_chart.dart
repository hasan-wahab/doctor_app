import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardChartsCustom extends StatelessWidget {
  const DashboardChartsCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Bar Chart
        Container(
          width: 165.w,
          height: 121.h,
          padding: EdgeInsets.all(10.r,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: AppColors.primaryColor
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Monthly Payments', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Expanded(child: CustomBarChart(data: [4, 7, 5, 6, 7, 3])),
            ],
          ),
        ),

        // Line Chart
        Container(
          width: 165.w,
          height: 121.h,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryColor
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sessions Consuming', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Expanded(child: CustomLineChart(data: [3, 4.5, 3.5, 5, 4.2, 4.8])),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------ Bar Chart ------------------
class CustomBarChart extends StatelessWidget {
  final List<double> data;
  const CustomBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxData = data.reduce((a, b) => a > b ? a : b);
      double barWidth = constraints.maxWidth / (data.length * 2);

      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data.map((value) {
          double barHeight = (value / maxData) * constraints.maxHeight;
          return Container(
            width: barWidth,
            height: barHeight,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }).toList(),
      );
    });
  }
}

// ------------------ Line Chart ------------------
class CustomLineChart extends StatelessWidget {
  final List<double> data;
  const CustomLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(data: data),
      child: Container()
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  _LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    double maxData = data.reduce((a, b) => a > b ? a : b);
    double stepX = size.width / (data.length - 1);

    Paint linePaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.teal.withOpacity(0.3), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path linePath = Path();
    Path fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      double x = stepX * i;
      double y = size.height - (data[i] / maxData) * size.height;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      if (i == data.length - 1) {
        fillPath.lineTo(x, size.height);
        fillPath.close();
      }
    }

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
