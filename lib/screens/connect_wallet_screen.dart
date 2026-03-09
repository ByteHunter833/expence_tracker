// ════════════════════════════════════════════
// CONNECT WALLET SCREEN
// Tabs: Cards | Accounts
// Package: flutter_credit_card
// ════════════════════════════════════════════

import 'package:expence_tracker/core/models/models.dart';
import 'package:expence_tracker/screens/billing_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

// ─── Theme colors ────────────────────────────────────────────────────────────
const _teal = Color(0xFF2A7C76);
const _tealLight = Color(0xFF3D9E8C);
const _textDark = Color(0xFF1A1A2E);
const _textGrey = Color(0xFF9CA3AF);

// ════════════════════════════════════════════
class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _teal,
      body: Column(
        children: [
          _Header(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _TabSelector(controller: _tabController),
                  const SizedBox(height: 4),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [_CardsTab(), _AccountsTab()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            const Expanded(
              child: Text(
                'Connect Wallet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 26,
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab Selector ─────────────────────────────────────────────────────────────
class _TabSelector extends StatelessWidget {
  final TabController controller;
  const _TabSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: _textDark,
        unselectedLabelColor: _textGrey,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Cards'),
          Tab(text: 'Accounts'),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// TAB 1 — CARDS
// ════════════════════════════════════════════
class _CardsTab extends StatefulWidget {
  const _CardsTab();

  @override
  State<_CardsTab> createState() => _CardsTabState();
}

class _CardsTabState extends State<_CardsTab> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = 'IRVAN MOSES';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onCreditCardModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }

  void _onAddCard() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Text(
            'Card added successfully!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
    );

    return Theme(
      data: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: _textDark, fontSize: 15),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: _teal,
          primary: _teal,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: _textGrey, fontSize: 12),
          labelStyle: const TextStyle(color: _textGrey, fontSize: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _teal, width: 1.5),
          ),
          enabledBorder: inputBorder,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Credit Card Widget ──
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate.isEmpty ? '22/01' : expiryDate,
              cardHolderName: cardHolderName.isEmpty
                  ? 'IRVAN MOSES'
                  : cardHolderName,
              cvvCode: cvvCode,
              bankName: 'Mono',
              showBackView: isCvvFocused,
              obscureCardNumber: false,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              isSwipeGestureEnabled: true,
              enableFloatingCard: true,
              cardBgColor: _tealLight,
              frontCardBorder: Border.all(color: Colors.transparent),
              backCardBorder: Border.all(color: Colors.transparent),
              onCreditCardWidgetChange: (_) {},
              padding: 16,
            ),

            // ── Title ──
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add your debit Card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'This card must be connected to a bank account\nunder your name',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textGrey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Credit Card Form ──
            CreditCardForm(
              formKey: _formKey,
              obscureCvv: true,
              obscureNumber: false,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: cardHolderName,
              expiryDate: expiryDate,
              inputConfiguration: const InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  labelText: 'DEBIT CARD NUMBER',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  labelText: 'EXPIRATION MM/YY',
                  hintText: 'MM/YY',
                ),
                cvvCodeDecoration: InputDecoration(
                  labelText: 'CVC',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  labelText: 'NAME ON CARD',
                ),
              ),
              onCreditCardModelChange: _onCreditCardModelChange,
            ),

            const SizedBox(height: 24),

            // ── Add Card Button ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onAddCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Add Card',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════
// TAB 2 — ACCOUNTS
// ════════════════════════════════════════════
class _AccountsTab extends StatefulWidget {
  const _AccountsTab();

  @override
  State<_AccountsTab> createState() => _AccountsTabState();
}

class _AccountsTabState extends State<_AccountsTab> {
  int _selectedIndex = 0;

  final List<AccountOption> _options = const [
    AccountOption(
      icon: Icons.account_balance,
      title: 'Bank Link',
      subtitle: 'Connect your bank account to deposit & fund',
    ),
    AccountOption(
      icon: Icons.attach_money,
      title: 'Microdeposits',
      subtitle: 'Connect bank in 5-7 days',
    ),
    AccountOption(
      icon: Icons.paypal,
      title: 'Paypal',
      subtitle: 'Connect your paypal account',
    ),
  ];

  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BillDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          // ── Options list ──
          ...List.generate(_options.length, (i) {
            final opt = _options[i];
            final sel = _selectedIndex == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: sel
                      ? const Color(0xFFF0F9F8)
                      : const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: sel ? _teal.withOpacity(0.25) : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: sel
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    // Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: sel
                            ? _teal.withOpacity(0.12)
                            : Colors.grey.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        opt.icon,
                        color: sel ? _teal : _textGrey,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: sel ? _textDark : _textGrey,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            opt.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: sel ? _teal : _textGrey,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Checkmark
                    if (sel)
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: _teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),

          const Spacer(),

          // ── Next Button ──
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: _onNext,
              style: OutlinedButton.styleFrom(
                foregroundColor: _teal,
                side: const BorderSide(color: _teal, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
