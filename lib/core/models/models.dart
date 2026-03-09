import 'package:flutter/material.dart';

class DetailRow {
  final String label;
  final String value;
  final Color? valueColor;
  const DetailRow({required this.label, required this.value, this.valueColor});
}

class SummaryRow {
  final String label;
  final String value;
  final bool negative;
  const SummaryRow({
    required this.label,
    required this.value,
    this.negative = false,
  });
}

class PaymentMethod {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  const PaymentMethod({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
  });
}

// ─── Data model ──────────────────────────────────────────────────────────────
class AccountOption {
  final IconData icon;
  final String title;
  final String subtitle;

  const AccountOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
