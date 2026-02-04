import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/alu_theme.dart';
import 'state/app_state.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/risk_status_screen.dart';
import 'screens/announcements_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'ALU Academic Assistant',
        theme: ALUTheme.getTheme(),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSignedUp = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (!_isSignedUp) {
      return SignupScreen(
        onSignupSuccess: () {
          setState(() {
            _isSignedUp = true;
          });
        },
      );
    }

    final screens = [
      const DashboardScreen(),
      const AssignmentsScreen(),
      const ScheduleScreen(),
      const AnnouncementsScreen(),
      const RiskStatusScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber),
            label: 'Risk',
          ),
        ],
      ),
    );
  }
}
