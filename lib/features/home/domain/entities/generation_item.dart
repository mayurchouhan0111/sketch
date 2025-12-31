import 'package:flutter/material.dart';

class GenerationItem {
  final String id;
  final String title;
  final String type; // "App" or "Web"
  final DateTime timestamp;
  final Color thumbnailColor;

  const GenerationItem({
    required this.id,
    required this.title,
    required this.type,
    required this.timestamp,
    required this.thumbnailColor,
  });
}
