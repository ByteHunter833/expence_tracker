// ════════════════════════════════════════════
// WALLET SCREEN
// ════════════════════════════════════════════
import 'package:expence_tracker/billing_screen.dart';
import 'package:expence_tracker/screens/connect_wallet_screen.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  final _transactions = [
    {
      'name': 'Upwork',
      'date': 'Today',
      'amount': '+\$ 850.00',
      'isPositive': true,
      'icon': Icons.work_outline,
      'iconColor': const Color(0xFF1DB954),
      'bgColor': const Color(0xFFE8F8EE),
    },
    {
      'name': 'Transfer',
      'date': 'Yesterday',
      'amount': '-\$ 85.00',
      'isPositive': false,
      'icon': Icons.person,
      'iconColor': Colors.white,
      'bgColor': const Color(0xFFD1D5DB),
    },
    {
      'name': 'Paypal',
      'date': 'Jan 30, 2022',
      'amount': '+\$ 1,406.00',
      'isPositive': true,
      'icon': Icons.payment,
      'iconColor': const Color(0xFF003087),
      'bgColor': const Color(0xFFE8EEF8),
    },
    {
      'name': 'Youtube',
      'date': 'Jan 16, 2022',
      'amount': '-\$ 11.99',
      'isPositive': false,
      'icon': Icons.play_circle_fill,
      'iconColor': const Color(0xFFFF0000),
      'bgColor': const Color(0xFFFEE8E8),
    },
  ];

  final _bills = [
    {
      'name': 'Netflix',
      'date': 'Feb 22, 2022',

      'icon': Icons.play_arrow_rounded,
      'iconColor': Colors.white,
      'bgColor': const Color(0xFFE50914),
    },
    {
      'name': 'Spotify',
      'date': 'Feb 24, 2022',

      'icon': Icons.music_note,
      'iconColor': Colors.white,
      'bgColor': const Color(0xFF1DB954),
    },
    {
      'name': 'iCloud',
      'date': 'Mar 01, 2022',

      'icon': Icons.cloud_outlined,
      'iconColor': Colors.white,
      'bgColor': const Color(0xFF007AFF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildBalanceCard(),
                    const SizedBox(height: 24),
                    _buildActions(),
                    const SizedBox(height: 24),
                    _buildTabs(),
                    const SizedBox(height: 16),
                    ...(_tabController.index == 0 ? _transactions : _bills).map(
                      (tx) => _buildTxItem(tx, _tabController.index == 1),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF2A7C76),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              const Text(
                'Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    right: 7,
                    top: 7,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6B35),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
          ),
          SizedBox(height: 8),
          Text(
            '\$ 2,548.00',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final actions = [
      {'icon': Icons.add, 'label': 'Add'},
      {'icon': Icons.grid_view_rounded, 'label': 'Pay'},
      {'icon': Icons.send_outlined, 'label': 'Send'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: actions.map((a) {
        return Column(
          children: [
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${a['label']} tapped'),
                      backgroundColor: const Color(0xFF2A7C76),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF2A7C76),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    a['icon'] as IconData,
                    color: const Color(0xFF2A7C76),
                    size: 26,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              a['label'] as String,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,

        labelColor: const Color(0xFF1A1A2E),
        unselectedLabelColor: const Color(0xFF9CA3AF),

        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),

        tabs: const [
          Tab(text: 'Transactions'),
          Tab(text: 'Upcoming Bills'),
        ],
      ),
    );
  }

  Widget _buildTxItem(Map<String, dynamic> tx, bool isBill) {
    return InkWell(
      onTap: isBill
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => tx['isPositive']
                      ? const TransactionDetailsIncomeScreen()
                      : const TransactionDetailsExpenseScreen(),
                ),
              );
            },
      child: Material(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: tx['bgColor'] as Color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  tx['icon'] as IconData,
                  color: tx['iconColor'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['name'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      tx['date'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              isBill
                  ? const SizedBox()
                  : Text(
                      tx['amount'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tx['isPositive'] as bool
                            ? const Color(0xFF2A7C76)
                            : const Color(0xFFEF4444),
                      ),
                    ),

              isBill
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConnectWalletScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,

                        backgroundColor: const Color(0xffECF9F8),
                        foregroundColor: const Color(0xff438883),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Pay', style: TextStyle(fontSize: 16)),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
