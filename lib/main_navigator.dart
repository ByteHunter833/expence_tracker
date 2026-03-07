import 'package:expence_tracker/screens/add_expense_screen.dart';
import 'package:expence_tracker/screens/home_screen.dart';
import 'package:expence_tracker/screens/profile_screen.dart';
import 'package:expence_tracker/screens/statistics_screen.dart';
import 'package:expence_tracker/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = const [
    HomeScreen(),
    StatisticsScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) => _screens[index],
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: _screens.length,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _currentIndex == 0 ? _buildFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNav() {
    const icons = [
      Icons.home_filled,
      Icons.bar_chart_rounded,
      Icons.account_balance_wallet_rounded,
      Icons.person_rounded,
    ];

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x552A7C76),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: BottomAppBar(
        shadowColor: const Color(0x552A7C76),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (i) {
            return GestureDetector(
              onTap: () {
                setState(() => _currentIndex = i);
                _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(
                icons[i],
                size: 26,
                color: _currentIndex == i
                    ? const Color(0xFF2A7C76)
                    : const Color(0xFFB0B8C1),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        );
      },
      child: Container(
        width: 58,
        height: 58,
        decoration: const BoxDecoration(
          color: Color(0xFF2A7C76),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x552A7C76),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
