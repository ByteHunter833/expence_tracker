// ════════════════════════════════════════════
// ADD EXPENSE SCREEN
// ════════════════════════════════════════════
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _amount = '48.00';
  final String _selectedName = 'Netflix';
  String _selectedDate = 'Tue, 22 Feb 2022';

  void _onKey(String key) {
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
          Expanded(child: SingleChildScrollView(child: _buildForm())),
          _buildKeypad(),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Text(
                'Add Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('NAME'),
          const SizedBox(height: 8),
          _nameField(),
          const SizedBox(height: 16),
          _label('AMOUNT'),
          const SizedBox(height: 8),
          _amountField(),
          const SizedBox(height: 16),
          _label('DATE'),
          const SizedBox(height: 8),
          _dateField(),
          const SizedBox(height: 16),
          _label('INVOICE'),
          const SizedBox(height: 8),
          _invoiceField(),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Color(0xFF9CA3AF),
      letterSpacing: 0.8,
    ),
  );

  Widget _nameField() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE5E7EB)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE50914),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            _selectedName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF)),
      ],
    ),
  );

  Widget _amountField() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF2A7C76), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(
          '\$ $_amount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2A7C76),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => _amount = '0.00'),
          child: const Text(
            'Clear',
            style: TextStyle(
              color: Color(0xFF2A7C76),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _dateField() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE5E7EB)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(
          _selectedDate,
          style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A2E)),
        ),
        const Spacer(),
        GestureDetector(
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
              final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
            Icons.calendar_today_outlined,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
        ),
      ],
    ),
  );

  Widget _invoiceField() => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE5E7EB)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF9CA3AF)),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 18, color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(width: 8),
        const Text(
          'Add Invoice',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 15),
        ),
      ],
    ),
  );

  Widget _buildKeypad() {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['+*#', '0', '⌫'],
    ];
    final subs = {
      '2': 'ABC',
      '3': 'DEF',
      '4': 'GHI',
      '5': 'JKL',
      '6': 'MNO',
      '7': 'PQRS',
      '8': 'TUV',
      '9': 'WXYZ',
    };

    return Container(
      color: const Color(0xFFF3F4F6),
      child: Column(
        children: rows
            .map(
              (row) => Row(
                children: row
                    .map(
                      (key) => Expanded(
                        child: GestureDetector(
                          onTap: () => _onKey(key),
                          child: Container(
                            height: 66,
                            margin: const EdgeInsets.all(1),
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (key == '⌫')
                                  const Icon(
                                    Icons.backspace_outlined,
                                    size: 22,
                                    color: Color(0xFF6B7280),
                                  )
                                else
                                  Text(
                                    key,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                  ),
                                if (subs.containsKey(key))
                                  Text(
                                    subs[key]!,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF9CA3AF),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
