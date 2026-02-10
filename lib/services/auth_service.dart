import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserCourses = 'user_courses';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final localLogin = prefs.getBool(_keyIsLoggedIn) ?? false;
    return localLogin;
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  Future<List<String>> getUserCourses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyUserCourses) ?? [];
  }

  Future<bool> signup(String email, String password, List<String> courses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email);
    await prefs.setStringList(_keyUserCourses, courses);
    await prefs.setBool(_keyIsLoggedIn, true);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString(_keyUserEmail);
    
    if (storedEmail == email) {
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }
}