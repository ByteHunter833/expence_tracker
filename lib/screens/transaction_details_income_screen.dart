import 'package:expence_tracker/core/colors/colors.dart';
import 'package:expence_tracker/core/enums/enums.dart';
import 'package:expence_tracker/core/models/models.dart';
import 'package:expence_tracker/widgets/transaction_details.dart';
import 'package:flutter/material.dart';

class TransactionDetailsIncomeScreen extends StatelessWidget {
  const TransactionDetailsIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TransactionDetails(
      type: TxType.income,
      amount: '\$ 850.00',
      rows: const [
        DetailRow(
          label: 'Status',
          value: 'Income',
          valueColor: AppColors.green,
        ),
        DetailRow(label: 'From', value: 'Upwork Escrow'),
        DetailRow(label: 'Time', value: '10:00 AM'),
        DetailRow(label: 'Date', value: 'Feb 30, 2022'),
      ],
      summaryRows: const [
        SummaryRow(label: 'Earnings', value: '\$ 870.00'),
        SummaryRow(label: 'Fee', value: '- \$ 20.00', negative: true),
      ],
      total: '\$ 850.00',
      avatarWidget: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFFF0F4FF),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'Up',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Color(0xFF6FCF3E), Color(0xFF00A86B)],
                ).createShader(const Rect.fromLTWH(0, 0, 50, 30)),
            ),
          ),
        ),
      ),
      buttonLabel: 'Download Receipt',
      onButton: () {},
    );
  }
}
