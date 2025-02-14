// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously
import 'package:feed_the_needy/Needer_pages/Needer_available_food.dart';
import 'package:feed_the_needy/Needer_pages/Request_page.dart';
import 'package:feed_the_needy/Needer_pages/needer_dashboard.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
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
          const FoodNeederDashboardPage(),
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: AppLocalizations.of(context)!.dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.food_bank),
            label: AppLocalizations.of(context)!.availableFoodTab,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: AppLocalizations.of(context)!.yourRequests,
          ),
        ],
      ),
    );
  }
}
