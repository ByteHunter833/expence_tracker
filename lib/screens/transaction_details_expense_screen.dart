import 'package:expence_tracker/core/colors/colors.dart';
import 'package:expence_tracker/core/enums/enums.dart';
import 'package:expence_tracker/core/models/models.dart';
import 'package:expence_tracker/widgets/transaction_details.dart';
import 'package:flutter/material.dart';

class TransactionDetailsExpenseScreen extends StatelessWidget {
  const TransactionDetailsExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TransactionDetails(
      type: TxType.expense,
      amount: '\$ 85.00',
      rows: const [
        DetailRow(label: 'Status', value: 'Expense', valueColor: AppColors.red),
        DetailRow(label: 'To', value: 'Claire Jovalski'),
        DetailRow(label: 'Time', value: '04:30 PM'),
        DetailRow(label: 'Date', value: 'Feb 29, 2022'),
      ],
      summaryRows: const [
        SummaryRow(label: 'Spending', value: '\$ 85.00'),
        SummaryRow(label: 'Fee', value: '- \$ 0.99', negative: true),
      ],
      total: '\$ 84.00',
      avatarWidget: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: NetworkImage('https://i.pravatar.cc/150?img=47'),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
          ],
        ),
      ),
      buttonLabel: 'Download Receipt',
      onButton: () {},
    );
  }
}
