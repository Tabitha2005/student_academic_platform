import 'package:flutter/material.dart';
import '../theme/alu_theme.dart';

class SignupScreen extends StatefulWidget {
  final Function onSignupSuccess;

  const SignupScreen({super.key, required this.onSignupSuccess});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Set<String> _selectedCourses = {};

  final List<Map<String, String>> _availableCourses = [
    {'name': 'Computer Science', 'icon': '💻'},
    {'name': 'Business Administration', 'icon': '📊'},
    {'name': 'Engineering', 'icon': '⚙️'},
    {'name': 'Liberal Arts', 'icon': '📚'},
    {'name': 'Environmental Science', 'icon': '🌍'},
  ];

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate() && _emailController.text.isNotEmpty) {
      if (_selectedCourses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one course'),
            backgroundColor: ALUTheme.warningRed,
          ),
        );
        return;
      }
      widget.onSignupSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: ALUTheme.warningRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header with Icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ALUTheme.accentYellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('🎓', style: TextStyle(fontSize: 32)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ALU Academic',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textWhite,
                            ),
                          ),
                          Text(
                            'Assistant',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.accentYellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your personal academic companion for success',
                  style: TextStyle(
                    fontSize: 14,
                    color: ALUTheme.textWhite.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 32),
                // Email Section
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                  ),
                ),
                const SizedBox(height: 12),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'student@alu.edu',
                      prefixIcon: Icon(
                        Icons.email,
                        color: ALUTheme.accentYellow,
                      ),
                      filled: true,
                      fillColor: ALUTheme.cardWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      if (!value!.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                // Courses Section
                Text(
                  'Select Your Courses',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose the courses you\'re enrolled in',
                  style: TextStyle(
                    fontSize: 12,
                    color: ALUTheme.textWhite.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 16),
                // Course Cards
                ..._availableCourses.map((course) {
                  bool isSelected = _selectedCourses.contains(course['name']);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCourses.remove(course['name']);
                          } else {
                            _selectedCourses.add(course['name']!);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ALUTheme.accentYellow.withValues(alpha: 0.15)
                              : ALUTheme.cardWhite.withValues(alpha: 0.08),
                          border: Border.all(
                            color: isSelected
                                ? ALUTheme.accentYellow
                                : ALUTheme.cardWhite.withValues(alpha: 0.3),
                            width: isSelected ? 2 : 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Checkbox - Large and Visible
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ALUTheme.accentYellow
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? ALUTheme.accentYellow
                                      : ALUTheme.cardWhite.withValues(
                                          alpha: 0.5,
                                        ),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: ALUTheme.primaryDark,
                                      size: 20,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            // Course Icon and Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        course['icon']!,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          course['name']!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ALUTheme.textWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 32),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ALUTheme.accentYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ALUTheme.primaryDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Info Text
                Center(
                  child: Text(
                    'You can change your courses anytime',
                    style: TextStyle(
                      fontSize: 12,
                      color: ALUTheme.textWhite.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
