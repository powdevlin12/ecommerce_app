import 'package:ercomerce_app/api/api.dart';
import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Setup fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation
    _animationController.forward();

    // Navigate to Home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (Api.accessToken == "") {
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            AppRoutes.login,
            (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            AppRoutes.main,
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App logo or icon
                    Icon(
                      Icons.flash_on,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    // App name or title
                    Text(
                      'TD Ecommerce',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
