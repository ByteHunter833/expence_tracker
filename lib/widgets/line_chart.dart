import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  // Teal/green palette matching the design
  static const Color lineColor = Color(0xFF3D9E8C);

  static const Color gridColor = Color(0xFFEEEEEE);
  static const Color tooltipBg = Color(0xFFFFFFFF);
  static const Color tooltipText = Color(0xFF2C2C2C);
  static const Color axisLabelColor = Color(0xFFAAAAAA);

  bool showAvg = false;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(showAvg ? avgData() : mainData()),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg
                    ? Colors.black.withValues(alpha: 0.4)
                    : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: axisLabelColor,
    );
    // Monthly labels matching the design: Mar Apr May Jun Jul Aug Sep
    String text = switch (value.toInt()) {
      0 => 'Mar',
      2 => 'Apr',
      4 => 'May',
      6 => 'Jun',
      8 => 'Jul',
      10 => 'Aug',
      11 => 'Sep',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    // Hide axis labels — design has none on the left
    return const SizedBox.shrink();
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => tooltipBg,
          tooltipBorderRadius: BorderRadius.circular(12),
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          tooltipBorder: BorderSide(color: Colors.grey.shade200, width: 1),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              // Map Y value to dollar amount (Y: 0–6 → $0–$2000 approx)
              final amount = (spot.y * 400).toStringAsFixed(0);
              return LineTooltipItem(
                '\$$amount',
                const TextStyle(
                  color: tooltipText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: lineColor.withValues(alpha: 0.4),
                strokeWidth: 1.5,
                dashArray: [5, 5],
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 6,
                      color: lineColor,
                      strokeWidth: 3,
                      strokeColor: Colors.white,
                    ),
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: gridColor, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 0,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 1.0),
            FlSpot(2, 1.5),
            FlSpot(4, 3.8), // peak around May
            FlSpot(6, 2.8),
            FlSpot(8, 3.5),
            FlSpot(10, 2.5),
            FlSpot(11, 3.0),
          ],
          isCurved: true,
          curveSmoothness: 0.35,
          color: lineColor,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x553D9E8C), Color(0x003D9E8C)],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    const avgY = 2.73;
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: gridColor, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(12, (i) => FlSpot(i.toDouble(), avgY)),
          isCurved: false,
          color: lineColor.withValues(alpha: 0.6),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: lineColor.withValues(alpha: 0.08),
          ),
        ),
      ],
    );
  }
}
