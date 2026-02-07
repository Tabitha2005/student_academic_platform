import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/alu_theme.dart';
import 'state/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/risk_status_screen.dart';
import 'screens/announcements_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final _authService = AuthService();
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _showLogin = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      await Provider.of<AppState>(context, listen: false).loadData();
    }
    setState(() {
      _isLoggedIn = loggedIn;
      _isLoading = false;
    });
  }

  Future<void> _handleLoginSuccess() async {
    await Provider.of<AppState>(context, listen: false).loadData();
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleSignupSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _toggleAuthScreen() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    setState(() {
      _isLoggedIn = false;
      _showLogin = true;
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isLoggedIn) {
      return _showLogin
          ? LoginScreen(
              onLoginSuccess: _handleLoginSuccess,
              onNavigateToSignup: _toggleAuthScreen,
            )
          : SignupScreen(
              onSignupSuccess: _handleSignupSuccess,
              onNavigateToLogin: _toggleAuthScreen,
            );
    }

    final screens = [
      DashboardScreen(onLogout: _handleLogout),
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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_rounded),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_rounded),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: 'Risk',
          ),
        ],
      ),
    );
  }
}
