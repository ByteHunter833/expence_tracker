import 'package:expence_tracker/core/colors/colors.dart';
import 'package:expence_tracker/core/enums/enums.dart';
import 'package:expence_tracker/core/models/models.dart';
import 'package:expence_tracker/widgets/billing_conf_app_bar.dart';
import 'package:expence_tracker/widgets/billing_outline_button.dart';
import 'package:flutter/material.dart';

class TransactionDetails extends StatefulWidget {
  final TxType type;
  final String amount;
  final List<DetailRow> rows;
  final List<SummaryRow> summaryRows;
  final String total;
  final Widget avatarWidget;
  final String buttonLabel;
  final VoidCallback onButton;

  const TransactionDetails({
    super.key,
    required this.type,
    required this.amount,
    required this.rows,
    required this.summaryRows,
    required this.total,
    required this.avatarWidget,
    required this.buttonLabel,
    required this.onButton,
  });

  @override
  State<TransactionDetails> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetails> {
  bool _detailsExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.type == TxType.income;
    final badgeColor = isIncome
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE4E4);
    final badgeText = isIncome ? 'Income' : 'Expense';
    final badgeTextColor = isIncome ? AppColors.green : AppColors.red;

    return Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        children: [
          const BillingConfAppBar(title: 'Transaction Details'),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
                child: Column(
                  children: [
                    // Avatar
                    widget.avatarWidget,
                    const SizedBox(height: 10),
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Amount
                    Text(
                      widget.amount,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Transaction details collapsible
                    GestureDetector(
                      onTap: () =>
                          setState(() => _detailsExpanded = !_detailsExpanded),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transaction details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Icon(
                            _detailsExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.textGrey,
                          ),
                        ],
                      ),
                    ),

                    if (_detailsExpanded) ...[
                      const SizedBox(height: 12),
                      ...widget.rows.map((r) => _buildDetailRow(r)),
                    ],

                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 8),

                    // Summary rows
                    ...widget.summaryRows.map((r) => _buildSummaryRow(r)),

                    const SizedBox(height: 8),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 12),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          widget.total,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Button
                    BillingOutlineButton(
                      label: widget.buttonLabel,
                      onTap: widget.onButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(DetailRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            // ignore: prefer_const_constructors
            style: TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: row.valueColor ?? AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(SummaryRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: row.negative ? AppColors.red : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
