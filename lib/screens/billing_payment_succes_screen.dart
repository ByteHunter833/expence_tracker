import 'package:expence_tracker/core/colors/colors.dart';
import 'package:expence_tracker/widgets/billing_conf_app_bar.dart';
import 'package:expence_tracker/widgets/billing_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BillPaymentSuccessScreen extends StatefulWidget {
  const BillPaymentSuccessScreen({super.key});

  @override
  State<BillPaymentSuccessScreen> createState() =>
      _BillPaymentSuccessScreenState();
}

class _BillPaymentSuccessScreenState extends State<BillPaymentSuccessScreen> {
  bool _detailsExpanded = true;
  final String _txId = '2092913832472';

  void _copyTxId() {
    Clipboard.setData(ClipboardData(text: _txId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text(
          'Transaction ID copied!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        children: [
          const BillingConfAppBar(title: 'Bill Payment'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
                child: Column(
                  children: [
                    // Success icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: AppColors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Payment Successfully',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Youtube Premium',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                    ),

                    const SizedBox(height: 28),

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
                      _detailRow('Payment method', 'Debit Card'),
                      _detailRow(
                        'Status',
                        'Completed',
                        valueColor: AppColors.green,
                      ),
                      _detailRow('Time', '08:15 AM'),
                      _detailRow('Date', 'Feb 28, 2022'),
                      // Transaction ID with copy
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Transaction ID',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${_txId.substring(0, 10)}..',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: _copyTxId,
                                  child: const Icon(
                                    Icons.copy_outlined,
                                    size: 16,
                                    color: AppColors.textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 8),

                    _detailRow('Price', '\$ 11.99'),
                    _detailRow('Fee', '- \$ 1.99', valueColor: AppColors.red),

                    const SizedBox(height: 8),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          '\$ 13.98',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    BillingOutlineButton(label: 'Share Receipt', onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor ?? AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
