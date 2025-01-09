import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:feed_the_needy/pages/otp_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
              AnimatedPhoneEntryPage(), // Phone number entry page
            ],
          ),
          if (_currentPage < 3) // Only show the indicator for pages 0-2
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.black,
                    dotColor: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation2.json', height: 300, width: 300),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                'Welcome to FeedtheNeedy App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'From hotels to hearts—our app bridges the gap with food and compassion.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation4.json', height: 350, width: 350),
            const Text(
              'One app, countless smiles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'join us in reducing food waste and feeding those in need.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation1.json', height: 350, width: 350),
            const Text(
              'Get Started Today',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Sign up and choose your role to contribute to the cause.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedPhoneEntryPage extends StatefulWidget {
  @override
  _AnimatedPhoneEntryPageState createState() => _AnimatedPhoneEntryPageState();
}

class _AnimatedPhoneEntryPageState extends State<AnimatedPhoneEntryPage> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+91'; // Default country code (India)
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Verification',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'metropolis'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('assets/phone.json'),
            const Text(
              'Get Started Today',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Reduce food wastage, fight hunger, and build a world where every meal counts.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: (CountryCode countryCode) {
                    setState(() {
                      _selectedCountryCode = countryCode.dialCode!;
                    });
                  },
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  favorite: ['+91', 'US'],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: InkWell(
                onTap: _isLoading
                    ? null
                    : () async {
                        final phoneNumber =
                            _selectedCountryCode + _phoneController.text.trim();
                        if (phoneNumber.isEmpty) {
                          _showSnackBar(
                              context, "Phone number cannot be empty");
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          // Send OTP
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((userCredential) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPScreen(
                                        verificationId:
                                            credential.verificationId ?? ''),
                                  ),
                                );
                              });
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              _showSnackBar(
                                  context, "Verification failed: ${e.message}");
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OTPScreen(verificationId: verificationId),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              setState(() {
                                _isLoading = false;
                              });
                            },
                          );
                        } catch (e) {
                          _showSnackBar(context, "An error occurred: $e");
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                borderRadius: BorderRadius.circular(30), // For rounded corners
                splashColor: const Color.fromARGB(255, 203, 212, 227)
                    .withOpacity(0.2), // Splash effect
                child: Ink(
                  decoration: BoxDecoration(
                    color: _isLoading
                        ? Colors.black87
                        : Colors.black, // Button color
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Get Started",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}