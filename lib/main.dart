import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/pages/onboarding_screen.dart';
import 'package:feed_the_needy/pages/role_selection.dart';
import 'package:feed_the_needy/Delivery_parntner/delivery_partner_home.dart';
import 'package:feed_the_needy/Donor_pages/donar_home.dart';
import 'package:feed_the_needy/Needer_pages/needer_home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("8e65f1ef-3ae2-4282-ad4d-cee4e5d41c40");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default locale

  @override
  void initState() {
    super.initState();
    _loadLocale(); // Load saved locale
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString('selected_locale');
    if (savedLocale != null) {
      setState(() {
        _locale = Locale(savedLocale);
      });
    }
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selected_locale', locale.languageCode); // Save locale
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Feed The Needy',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ta'), // Tamil
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}

// SplashScreen with background AuthCheck
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthCheck();
  }

  /// Perform background AuthCheck logic
  void _navigateToAuthCheck() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash duration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthCheck()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash_animation.gif',
          width: 500,
          height: 600,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// AuthCheck Logic
class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: Center(child: Lottie.asset('assets/loading.json')));
        }
        if (snapshot.hasData) {
          return const RoleChecker();
        } else {
          return OnboardingScreen();
        }
      },
    );
  }
}

// Role Checker Logic
class RoleChecker extends StatelessWidget {
  const RoleChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return OnboardingScreen();
    }

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: Center(
                  child: Lottie.asset('assets/loading.json',
                      height: 170, width: 170)));
        }

        if (snapshot.data?.exists ?? false) {
          String role = snapshot.data?.get('role') ?? 'unknown';
          if (role == 'Food Donor') {
            return const HomeFoodDonor();
          } else if (role == 'Food Needer') {
            return const HomeFoodNeeder();
          } else if (role == 'Delivery Partner') {
            return const DeliveryPartnerHome();
          } else {
            return const RoleSelectionPage();
          }
        } else {
          return const RoleSelectionPage();
        }
      },
    );
  }
}
