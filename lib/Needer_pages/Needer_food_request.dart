// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:feed_the_needy/Donor_pages/Donor_dashboard_page.dart';
import 'package:feed_the_needy/Needer_pages/Needer_available_food.dart';
import 'package:feed_the_needy/Needer_pages/Request_page.dart';
import 'package:flutter/material.dart';

class NeederFoodRequestPage extends StatefulWidget {
  const NeederFoodRequestPage({super.key});

  @override
  _NeederPageState createState() => _NeederPageState();
}

class _NeederPageState extends State<NeederFoodRequestPage> {
  int _currentIndex = 1; // Default to "Available Food"
  final PageController _pageController = PageController(initialPage: 1);

  // Navigation function for bottom navigation
  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const DonorDashboardPage(),
          AvailableFoodPage(),
          RequestsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Available Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Your Requests',
          ),
        ],
      ),
    );
  }
}
