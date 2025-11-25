// lib/screens/auth_screen.dart
// Figma-style beautiful UI – logic unchanged

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final auth = ref.read(authServiceProvider);

    setState(() => isLoading = true);

    try {
      if (isLogin) {
        await auth.signInWithEmail(
          _emailCtrl.text.trim(),
          _passCtrl.text.trim(),
        );
      } else {
        await auth.registerWithEmail(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text.trim(),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),

              /// 🔥 Logo Circle
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF39A7A),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.12),
                      blurRadius: 24,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(28),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 44,
                ),
              ),

              const SizedBox(height: 18),

              /// Heading
              Text(
                isLogin ? "Welcome Back" : "Create Your Account",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                isLogin
                    ? "Let’s continue building habits 🔥"
                    : "Build habits, one day at a time.",
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              /// Card Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.07),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name (only register)
                    if (!isLogin) ...[
                      const Text("Name"),
                      const SizedBox(height: 6),
                      _field(_nameCtrl, "Your name", Icons.person),
                      const SizedBox(height: 16),
                    ],

                    /// Email
                    const Text("Email"),
                    const SizedBox(height: 6),
                    _field(
                      _emailCtrl,
                      "example@gmail.com",
                      Icons.email_outlined,
                      keyboard: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    /// Password
                    const Text("Password"),
                    const SizedBox(height: 6),
                    _field(
                      _passCtrl,
                      "•••••••",
                      Icons.lock_outline,
                      obscure: true,
                    ),

                    const SizedBox(height: 24),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF39A7A),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text(
                                isLogin ? "Login" : "Create Account",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () => setState(() => isLogin = !isLogin),
                child: Text.rich(
                  TextSpan(
                    text: isLogin
                        ? "Don't have an account? "
                        : "Already have an account? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: isLogin ? "Register" : "Login",
                        style: const TextStyle(
                          color: Color(0xFFF39A7A),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String hint,
    IconData icon, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: ctrl,
              obscureText: obscure,
              keyboardType: keyboard,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
