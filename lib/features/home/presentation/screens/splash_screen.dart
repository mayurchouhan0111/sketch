import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center Lottie Animation
            SizedBox(
              width: 500, 
              height: 500,
              child: Lottie.asset(
                'assets/animations/splash.json',
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the animation to last exactly the composition duration
                  _controller
                    ..duration = composition.duration
                    ..forward().then((value) {
                       // Navigate after animation completes + small buffer
                       Future.delayed(const Duration(milliseconds: 500), () {
                         if (mounted) context.go('/');
                       });
                    });
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline, color: Colors.red, size: 50);
                },
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 24),

            // App Name with Premium Fade-In
            Text(
              "Sketch AI",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -1.0,
              ),
            ).animate()
             .fadeIn(duration: 800.ms, delay: 1000.ms) // Delay text to appear slightly after animation starts
             .moveY(begin: 10, end: 0, duration: 600.ms, curve: Curves.easeOut),
             
             const SizedBox(height: 8),
             
             Text(
               "Design Freedom",
               style: GoogleFonts.inter(
                 fontSize: 14,
                 color: Colors.white38,
                 letterSpacing: 2.0
               ),
             ).animate()
              .fadeIn(duration: 800.ms, delay: 1500.ms)
          ],
        ),
      ),
    );
  }
}
