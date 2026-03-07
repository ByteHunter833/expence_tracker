// ════════════════════════════════════════════
// TRANSACTION & BILL SCREENS (5 screens)
// 1. TransactionDetailsIncome
// 2. TransactionDetailsExpense
// 3. BillDetailsScreen
// 4. BillPaymentConfirmScreen
// 5. BillPaymentSuccessScreen
// ════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Colors ──────────────────────────────────────────────────────────────────
const _teal = Color(0xFF2A7C76);
const _textDark = Color(0xFF1A1A2E);
const _textGrey = Color(0xFF9CA3AF);
const _bgCard = Color(0xFFF8F9FA);
const _green = Color(0xFF22C55E);
const _red = Color(0xFFEF4444);

// ════════════════════════════════════════════
// 1. TRANSACTION DETAILS — INCOME
// ════════════════════════════════════════════
class TransactionDetailsIncomeScreen extends StatelessWidget {
  const TransactionDetailsIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _TransactionDetailsScreen(
      type: _TxType.income,
      amount: '\$ 850.00',
      rows: const [
        _DetailRow(label: 'Status', value: 'Income', valueColor: _green),
        _DetailRow(label: 'From', value: 'Upwork Escrow'),
        _DetailRow(label: 'Time', value: '10:00 AM'),
        _DetailRow(label: 'Date', value: 'Feb 30, 2022'),
      ],
      summaryRows: const [
        _SummaryRow(label: 'Earnings', value: '\$ 870.00'),
        _SummaryRow(label: 'Fee', value: '- \$ 20.00', negative: true),
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

// ════════════════════════════════════════════
// 2. TRANSACTION DETAILS — EXPENSE
// ════════════════════════════════════════════
class TransactionDetailsExpenseScreen extends StatelessWidget {
  const TransactionDetailsExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _TransactionDetailsScreen(
      type: _TxType.expense,
      amount: '\$ 85.00',
      rows: const [
        _DetailRow(label: 'Status', value: 'Expense', valueColor: _red),
        _DetailRow(label: 'To', value: 'Claire Jovalski'),
        _DetailRow(label: 'Time', value: '04:30 PM'),
        _DetailRow(label: 'Date', value: 'Feb 29, 2022'),
      ],
      summaryRows: const [
        _SummaryRow(label: 'Spending', value: '\$ 85.00'),
        _SummaryRow(label: 'Fee', value: '- \$ 0.99', negative: true),
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

// ─── Shared Transaction Details Template ─────────────────────────────────────
enum _TxType { income, expense }

class _TransactionDetailsScreen extends StatefulWidget {
  final _TxType type;
  final String amount;
  final List<_DetailRow> rows;
  final List<_SummaryRow> summaryRows;
  final String total;
  final Widget avatarWidget;
  final String buttonLabel;
  final VoidCallback onButton;

  const _TransactionDetailsScreen({
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
  State<_TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<_TransactionDetailsScreen> {
  bool _detailsExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.type == _TxType.income;
    final badgeColor = isIncome
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE4E4);
    final badgeText = isIncome ? 'Income' : 'Expense';
    final badgeTextColor = isIncome ? _green : _red;

    return Scaffold(
      backgroundColor: _teal,
      body: Column(
        children: [
          const _AppBar(title: 'Transaction Details'),
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
                        color: _textDark,
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
                              color: _textDark,
                            ),
                          ),
                          Icon(
                            _detailsExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: _textGrey,
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
                            color: _textDark,
                          ),
                        ),
                        Text(
                          widget.total,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _textDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Button
                    _OutlineButton(
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

  Widget _buildDetailRow(_DetailRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: const TextStyle(color: _textGrey, fontSize: 14),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: row.valueColor ?? _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(_SummaryRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: const TextStyle(color: _textGrey, fontSize: 14),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: row.negative ? _red : _textDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// 3. BILL DETAILS SCREEN
// ════════════════════════════════════════════
class BillDetailsScreen extends StatefulWidget {
  const BillDetailsScreen({super.key});

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  int _selectedPayment = 0; // 0 = Debit Card, 1 = Paypal

  final List<_PaymentMethod> _methods = const [
    _PaymentMethod(
      icon: Icons.credit_card,
      iconColor: _teal,
      iconBg: Color(0xFFE8F5F3),
      label: 'Debit Card',
    ),
    _PaymentMethod(
      icon: Icons.paypal,
      iconColor: Color(0xFF003087),
      iconBg: Color(0xFFE8EEF9),
      label: 'Paypal',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _teal,
      body: Column(
        children: [
          const _AppBar(title: 'Bill Details'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE8E8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.play_circle_fill,
                            color: Color(0xFFFF0000),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Youtube Premium',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: _textDark,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Feb 28, 2022',
                              style: TextStyle(color: _textGrey, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 8),

                    // Price / Fee
                    _billRow('Price', '\$ 11.99'),
                    _billRow('Fee', '\$ 1.99'),

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
                            color: _textDark,
                          ),
                        ),
                        Text(
                          '\$ 13.98',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: _textDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Select payment method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Payment methods
                    ...List.generate(_methods.length, (i) {
                      final m = _methods[i];
                      final sel = _selectedPayment == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedPayment = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? const Color(0xFFF0F9F8) : _bgCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: sel
                                  ? _teal.withOpacity(0.3)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: m.iconBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  m.icon,
                                  color: m.iconColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  m.label,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sel ? _teal : _textGrey,
                                  ),
                                ),
                              ),
                              // Radio
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: sel ? _teal : _textGrey,
                                    width: 2,
                                  ),
                                ),
                                child: sel
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            color: _teal,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const Spacer(),

                    // Pay Now button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BillPaymentConfirmScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _teal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'Pay Now',
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

  Widget _billRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: _textGrey, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              color: _textDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// 4. BILL PAYMENT CONFIRM SCREEN
// ════════════════════════════════════════════
class BillPaymentConfirmScreen extends StatelessWidget {
  const BillPaymentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _teal,
      body: Column(
        children: [
          const _AppBar(title: 'Bill Payment'),
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
                          color: _textDark,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'You will pay '),
                          TextSpan(
                            text: 'Youtube Premium',
                            style: TextStyle(
                              color: _teal,
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
                        color: _textDark,
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
                            color: _textDark,
                          ),
                        ),
                        Text(
                          '\$ 13.98',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: _textDark,
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
                          backgroundColor: _teal,
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
          Text(label, style: const TextStyle(color: _textGrey, fontSize: 14)),
          Text(
            value,
            style:
                valueStyle ??
                const TextStyle(
                  color: _textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// 5. BILL PAYMENT SUCCESS SCREEN
// ════════════════════════════════════════════
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
        backgroundColor: _teal,
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
      backgroundColor: _teal,
      body: Column(
        children: [
          const _AppBar(title: 'Bill Payment'),
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
                        color: _teal,
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
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Youtube Premium',
                      style: TextStyle(color: _textGrey, fontSize: 14),
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
                              color: _textDark,
                            ),
                          ),
                          Icon(
                            _detailsExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: _textGrey,
                          ),
                        ],
                      ),
                    ),

                    if (_detailsExpanded) ...[
                      const SizedBox(height: 12),
                      _detailRow('Payment method', 'Debit Card'),
                      _detailRow('Status', 'Completed', valueColor: _green),
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
                              style: TextStyle(color: _textGrey, fontSize: 14),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${_txId.substring(0, 10)}..',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _textDark,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: _copyTxId,
                                  child: const Icon(
                                    Icons.copy_outlined,
                                    size: 16,
                                    color: _textGrey,
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
                    _detailRow('Fee', '- \$ 1.99', valueColor: _red),

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
                            color: _textDark,
                          ),
                        ),
                        Text(
                          '\$ 13.98',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: _textDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    _OutlineButton(label: 'Share Receipt', onTap: () {}),
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
          Text(label, style: const TextStyle(color: _textGrey, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor ?? _textDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// SHARED WIDGETS
// ════════════════════════════════════════════

class _AppBar extends StatelessWidget {
  final String title;
  const _AppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.more_horiz, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: _teal,
          side: const BorderSide(color: _teal, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ─── Data models ─────────────────────────────────────────────────────────────
class _DetailRow {
  final String label;
  final String value;
  final Color? valueColor;
  const _DetailRow({required this.label, required this.value, this.valueColor});
}

class _SummaryRow {
  final String label;
  final String value;
  final bool negative;
  const _SummaryRow({
    required this.label,
    required this.value,
    this.negative = false,
  });
}

class _PaymentMethod {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  const _PaymentMethod({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
  });
}
