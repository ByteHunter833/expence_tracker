// ════════════════════════════════════════════
// STATISTICS SCREEN — updated to match design
// ════════════════════════════════════════════

import 'package:expence_tracker/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriod = 0;
  int _selectedSpendingIndex = 1;
  final List<String> _periods = ['Day', 'Week', 'Month', 'Year'];

  final List<Map<String, dynamic>> _spendings = [
    {
      'name': 'Starbucks',
      'date': 'Jan 12, 2022',
      'amount': '- \$ 150.00',
      // Using a network image placeholder — replace with real asset
      'avatarWidget': _buildLogoAvatar(
        backgroundColor: const Color(0xFFEAF5EF),
        icon: Icons.local_cafe,
        iconColor: const Color(0xFF00704A),
      ),
    },
    {
      'name': 'Transfer',
      'date': 'Yesterday',
      'amount': '- \$ 85.00',
      'avatarWidget': _buildLogoAvatar(
        backgroundColor: const Color(0xFF9CA3AF),
        icon: Icons.person,
        iconColor: Colors.white,
      ),
    },
    {
      'name': 'Youtube',
      'date': 'Jan 16, 2022',
      'amount': '- \$ 11.99',
      'avatarWidget': _buildLogoAvatar(
        backgroundColor: const Color(0xFFFEE8E8),
        icon: Icons.play_circle_fill,
        iconColor: const Color(0xFFFF0000),
      ),
    },
  ];

  static Widget _buildLogoAvatar({
    required Color backgroundColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPeriodTabs(),
                  _buildChart(),
                  const SizedBox(height: 24),
                  _buildTopSpending(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistics',
                style: TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: SvgPicture.asset('assets/icons/ic_export.svg'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        1.0,
                      ),
                      backgroundColor: const Color(0xff29756F),
                      content: const Text('Export feature come soon'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Period tabs ─────────────────────────────────────────────────────────────
  Widget _buildPeriodTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: List.generate(_periods.length, (index) {
          final sel = _selectedPeriod == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedPeriod = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: sel ? const Color(0xFF2A7C76) : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                _periods[index],
                style: TextStyle(
                  color: sel ? Colors.white : const Color(0xFF9CA3AF),
                  fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Chart section ───────────────────────────────────────────────────────────
  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expense dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Expense',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Color(0xFF1A1A2E),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // fl_chart widget
          const LineChartSample2(),
        ],
      ),
    );
  }

  // ── Top Spending ────────────────────────────────────────────────────────────
  Widget _buildTopSpending() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Spending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Color(0xFF6B7280),
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Spending list
          ...List.generate(_spendings.length, (index) {
            final item = _spendings[index];
            final isSelected = _selectedSpendingIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedSpendingIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2A7C76) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isSelected
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    // Avatar / logo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: isSelected
                          ? Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                index == 0
                                    ? Icons.local_cafe
                                    : index == 1
                                    ? Icons.person
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          : item['avatarWidget'] as Widget,
                    ),
                    const SizedBox(width: 14),

                    // Name + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['date'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white.withOpacity(0.65)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount
                    Text(
                      item['amount'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
