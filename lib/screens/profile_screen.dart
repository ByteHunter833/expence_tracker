// ════════════════════════════════════════════
// PROFILE SCREEN
// ════════════════════════════════════════════
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.diamond_outlined,
        'label': 'Invite Friends',
        'iconColor': const Color(0xFF2A7C76),
        'bgColor': const Color(0xFFE8F5F4),
      },
      {
        'icon': Icons.person_outline,
        'label': 'Account info',
        'iconColor': const Color(0xFF6B7280),
        'bgColor': const Color(0xFFF3F4F6),
      },
      {
        'icon': Icons.people_outline,
        'label': 'Personal profile',
        'iconColor': const Color(0xFF6B7280),
        'bgColor': const Color(0xFFF3F4F6),
      },
      {
        'icon': Icons.mail_outline,
        'label': 'Message center',
        'iconColor': const Color(0xFF6B7280),
        'bgColor': const Color(0xFFF3F4F6),
      },
      {
        'icon': Icons.shield_outlined,
        'label': 'Login and security',
        'iconColor': const Color(0xFF6B7280),
        'bgColor': const Color(0xFFF3F4F6),
      },
      {
        'icon': Icons.lock_outline,
        'label': 'Data and privacy',
        'iconColor': const Color(0xFF6B7280),
        'bgColor': const Color(0xFFF3F4F6),
      },
    ];

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
                    const SizedBox(height: 60),
                    const Text(
                      'Enjelin Morgeana',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '@enjelin_morgeana',
                      style: TextStyle(fontSize: 13, color: Color(0xFF2A7C76)),
                    ),
                    const SizedBox(height: 28),
                    ...menuItems.map(
                      (item) => Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 14,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: item['bgColor'] as Color,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      item['icon'] as IconData,
                                      color: item['iconColor'] as Color,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    item['label'] as String,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),
                        ],
                      ),
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          color: const Color(0xFF2A7C76),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  // Title
                  const Expanded(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Notification
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
        ),
        // Decorative circle
        Positioned(
          top: -30,
          left: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),
        // Profile picture
        Positioned(
          bottom: -48,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5F4),

                    image: DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
