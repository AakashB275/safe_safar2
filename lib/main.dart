import 'package:flutter/material.dart';
import 'pages/sos_page.dart';
import './pages/landing_page.dart';
import './pages/sos_page.dart';
import './pages/home.dart' as home;
import './pages/login.dart' as login;
import './pages/signup.dart';

void main() {
  runApp(SafeTourApp());
}

class SafeTourApp extends StatelessWidget {
  const SafeTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeTour - Travel & Emergency',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/sos': (context) => login.LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/landingPage': (context) => TravelMainScreen(),
        '/home': (context) => home.TouristSafetyApp(),

        '/': (context) => SOSHomePage(
          emergencyContacts: [
            EmergencyContact(name: "Mom", phoneNumber: "+1234567890"),
            EmergencyContact(name: "Dad", phoneNumber: "+0987654321"),
          ],
        ),
      },
    );
  }
}
