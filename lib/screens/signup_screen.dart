import 'package:flutter/material.dart';
import '../theme/alu_theme.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onSignupSuccess;
  final VoidCallback onNavigateToLogin;

  const SignupScreen({
    super.key,
    required this.onSignupSuccess,
    required this.onNavigateToLogin,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Set<String> _selectedCourses = {};
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _availableCourses = [
    'Software Engineering',
    'Entrepreneurial Leadership',
    'International Business Trade (IBT)',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCourses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one course'),
          backgroundColor: ALUTheme.warningRed,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final success = await _authService.signup(
      _emailController.text.trim(),
      _passwordController.text,
      _selectedCourses.toList(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      widget.onSignupSuccess();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signup failed. Please try again.'),
            backgroundColor: ALUTheme.warningRed,
          ),
        );
      }
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
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
                      const SizedBox(height: 24),
                      
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textWhite,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: ALUTheme.accentYellow,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ALUTheme.accentYellow,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: ALUTheme.cardWhite,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password is required';
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                     
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: ALUTheme.accentYellow,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ALUTheme.accentYellow,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: ALUTheme.cardWhite,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
               
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
             
                ..._availableCourses.map((course) {
                  bool isSelected = _selectedCourses.contains(course);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCourses.remove(course);
                          } else {
                            _selectedCourses.add(course);
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
                          
                            Expanded(
                              child: Text(
                                course,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ALUTheme.textWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 32),
               
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ALUTheme.accentYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: ALUTheme.primaryDark,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
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
             
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: ALUTheme.textWhite.withValues(alpha: 0.7),
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onNavigateToLogin,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ALUTheme.accentYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
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
