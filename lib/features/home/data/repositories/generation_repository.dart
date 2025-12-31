import 'package:flutter/material.dart';
import '../../domain/entities/generation_item.dart';

class GenerationRepository {
  Future<List<GenerationItem>> getRecentGenerations() async {
    // Simulate network/db delay
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      GenerationItem(
        id: '1',
        title: 'Crypto Wallet Dashboard',
        type: 'App',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        thumbnailColor: const Color(0xFF6C63FF),
      ),
      GenerationItem(
        id: '2',
        title: 'Fitness Tracker',
        type: 'App',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        thumbnailColor: const Color(0xFFFF6584),
      ),
      GenerationItem(
        id: '3',
        title: 'SaaS Landing Page',
        type: 'Web',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        thumbnailColor: const Color(0xFF03DAC6),
      ),
      GenerationItem(
        id: '4',
        title: 'E-commerce Checkout',
        type: 'Web',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        thumbnailColor: const Color(0xFFFFB74D),
      ),
      GenerationItem(
        id: '5',
        title: 'Social Media Feed',
        type: 'App',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        thumbnailColor: const Color(0xFF29B6F6),
      ),
    ];
  }
}
