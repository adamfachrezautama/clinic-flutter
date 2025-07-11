import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/presentation/chat/pages/chat_page.dart';
import 'package:flutter_clinicapp/presentation/history/pages/history_page.dart';
import 'package:flutter_clinicapp/presentation/home/widgets/nav_item.dart';
import 'package:flutter_clinicapp/presentation/profile/pages/profile_page.dart';
import 'package:flutter_clinicapp/presentation/telemedis/pages/telemedis_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ChatPage(),
    const TelemedisPage(),

    const HistoryPage(),
    const ProfilePage(),

    // const HomePage(),
    // const OrdersPage(),
    // const Placeholder(),
    // const ManageMenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.lightBackground,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.chat.path,
              label: 'Chat',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
                iconPath: Assets.icons.telemedis.path,
                label: 'Telemedis',
                isActive: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                }),
            NavItem(
              iconPath: Assets.icons.note.path,
              label: 'History',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.profileCircle.path,
              label: 'Profile',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
