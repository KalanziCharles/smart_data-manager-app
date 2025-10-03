import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'alerts/alerts_screen.dart';
import 'suggestions/suggestions_screen.dart';
import 'settings/settings_screen.dart';

void main() {
  debugDisableShadows = true;
  runApp(const SmartDataManagerApp());
}

class SmartDataManagerApp extends StatelessWidget {
  const SmartDataManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Data Manager',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Use home instead of initialRoute to avoid conflicts
      home: const DashboardScreen(),
      // Define all routes
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/suggestions': (context) => const SuggestionsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      // Handle any unknown routes gracefully
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
