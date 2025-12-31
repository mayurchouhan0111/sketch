import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sketch UI Generator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 64, color: Colors.amber)
                .animate()
                .scale(duration: 600.ms, curve: Curves.easeOutBack)
                .shimmer(delay: 300.ms, duration: 1200.ms),
            const SizedBox(height: 24),
            Text(
              "Welcome to Sketch",
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            Text(
              "Ready to generate premium UIs.",
              style: Theme.of(context).textTheme.bodyLarge,
            ).animate(delay: 200.ms).fade().slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
