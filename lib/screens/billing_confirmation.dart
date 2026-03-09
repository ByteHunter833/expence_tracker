// ignore: unused_import
import 'package:expence_tracker/screens/billing_details_screen.dart';
import 'package:expence_tracker/core/colors/colors.dart';
import 'package:expence_tracker/screens/billing_payment_succes_screen.dart';
import 'package:expence_tracker/widgets/billing_conf_app_bar.dart';
import 'package:flutter/material.dart';

class BillPaymentConfirmScreen extends StatelessWidget {
  const BillPaymentConfirmScreen({super.key});

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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE8E8),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.play_circle_fill,
                          color: Color(0xFFFF0000),
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textDark,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'You will pay '),
                          TextSpan(
                            text: 'Youtube Premium',
                            style: TextStyle(
                              color: AppColors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' for one month with BCA OneKlik'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 8),

                    // Price (strikethrough style like design)
                    _confirmRow(
                      'Price',
                      '\$ 11.99',
                      valueStyle: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    _confirmRow('Fee', '\$ 1.99'),

                    const SizedBox(height: 8),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 12),

                    // Total
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

                    const Spacer(),

                    // Confirm and Pay button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BillPaymentSuccessScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'Confirm and Pay',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  Widget _confirmRow(String label, String value, {TextStyle? valueStyle}) {
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
            style:
                valueStyle ??
                const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
