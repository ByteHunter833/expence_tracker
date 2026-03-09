// ════════════════════════════════════════════
// ADD EXPENSE SCREEN — Improved UX/UI
// Uber-style keypad, same color palette
// ════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen>
    with SingleTickerProviderStateMixin {
  String _amount = '48.00';
  final String _selectedName = 'Netflix';
  String _selectedDate = 'Tue, 22 Feb 2022';
  late AnimationController _amountController;
  late Animation<double> _amountScale;

  @override
  void initState() {
    super.initState();
    _amountController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _amountScale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _amountController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onKey(String key) {
    HapticFeedback.lightImpact();
    _amountController.forward().then((_) => _amountController.reverse());
    setState(() {
      if (key == '⌫') {
        String raw = _amount.replaceAll('.', '');
        if (raw.length <= 1) {
          _amount = '0.00';
        } else {
          raw = raw.substring(0, raw.length - 1);
          _amount = (int.parse(raw) / 100).toStringAsFixed(2);
        }
      } else if (key != '+*#') {
        String raw = _amount.replaceAll('.', '') + key;
        _amount = (int.parse(raw) / 100).toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          _buildHeader(context),
          _buildAmountHero(),
          Expanded(child: SingleChildScrollView(child: _buildForm())),
          _buildKeypad(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFF2A7C76),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Add Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Amount shown prominently below header (Uber Eats / expense app pattern)
  Widget _buildAmountHero() {
    return Container(
      color: const Color(0xFF2A7C76),
      padding: const EdgeInsets.only(bottom: 24, top: 4),
      child: Center(
        child: ScaleTransition(
          scale: _amountScale,
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: '\$ ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: _amount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _formRow(
            icon: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFE50914),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            label: 'Name',
            value: _selectedName,
            trailing: const Icon(
              Icons.chevron_right,
              color: Color(0xFFD1D5DB),
              size: 20,
            ),
            isFirst: true,
          ),
          _divider(),
          _formRow(
            icon: _iconBox(
              Icons.calendar_today_outlined,
              const Color(0xFF2A7C76),
            ),
            label: 'Date',
            value: _selectedDate,
            trailing: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2022, 2, 22),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                  builder: (ctx, child) => Theme(
                    data: Theme.of(ctx).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF2A7C76),
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  final months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];
                  setState(
                    () => _selectedDate =
                        '${days[picked.weekday - 1]}, ${picked.day} ${months[picked.month - 1]} ${picked.year}',
                  );
                }
              },
              child: const Icon(
                Icons.chevron_right,
                color: Color(0xFFD1D5DB),
                size: 20,
              ),
            ),
          ),
          _divider(),
          _formRow(
            icon: _iconBox(
              Icons.receipt_long_outlined,
              const Color(0xFF6B7280),
            ),
            label: 'Invoice',
            value: 'Add attachment',
            valueColor: const Color(0xFFB0B7C3),
            trailing: const Icon(
              Icons.chevron_right,
              color: Color(0xFFD1D5DB),
              size: 20,
            ),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon, Color color) => Container(
    width: 34,
    height: 34,
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Icon(icon, color: color, size: 18),
  );

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, color: Color(0xFFF3F4F6)),
  );

  Widget _formRow({
    required Widget icon,
    required String label,
    required String value,
    required Widget trailing,
    Color? valueColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9CA3AF),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? const Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  // ── Uber-style keypad: large, rounded keys, dark bg, no sub-letters clutter
  Widget _buildKeypad() {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['+*#', '0', '⌫'],
    ];

    return Container(
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: rows.map((row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: row.asMap().entries.map((entry) {
                final key = entry.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: entry.key == 0 ? 0 : 4,
                      right: entry.key == 2 ? 0 : 4,
                    ),
                    child: _KeypadButton(
                      keyValue: key,
                      onTap: () => _onKey(key),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2A7C76),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Save Expense',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Standalone keypad button widget for clean separation
class _KeypadButton extends StatefulWidget {
  final String keyValue;
  final VoidCallback onTap;

  const _KeypadButton({required this.keyValue, required this.onTap});

  @override
  State<_KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<_KeypadButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isBackspace = widget.keyValue == '⌫';
    final isSpecial = widget.keyValue == '+*#';

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        height: 62,
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFFD1D5DB) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: isBackspace
              ? Icon(
                  Icons.backspace_outlined,
                  size: 22,
                  color: _pressed
                      ? const Color(0xFF374151)
                      : const Color(0xFF6B7280),
                )
              : Text(
                  widget.keyValue,
                  style: TextStyle(
                    fontSize: isSpecial ? 14 : 22,
                    fontWeight: FontWeight.w500,
                    color: _pressed
                        ? const Color(0xFF111827)
                        : isSpecial
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF111827),
                    letterSpacing: isSpecial ? 1 : 0,
                  ),
                ),
        ),
      ),
    );
  }
}
