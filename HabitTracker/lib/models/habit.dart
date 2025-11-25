import 'package:flutter/material.dart';
import '../constants/icons.dart'; // your icon list

class Habit {
  final String id;
  final String name;
  final int iconIndex; // index from icon list
  final int colorHex;
  final int streak;
  final DateTime? lastCompletedAt;

  Habit({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.colorHex,
    required this.streak,
    required this.lastCompletedAt,
  });

  /// -------- Database Mapping --------

  factory Habit.fromMap(String id, Map<dynamic, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'] ?? '',
      iconIndex: map['iconIndex'] ?? 0,
      colorHex: map['colorHex'] ?? 0xFFAAAAAA,
      streak: map['streak'] ?? 0,
      lastCompletedAt: map['lastCompletedAt'] != null
          ? DateTime.tryParse(map['lastCompletedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconIndex': iconIndex,
      'colorHex': colorHex,
      'streak': streak,
      'lastCompletedAt': lastCompletedAt?.toIso8601String(),
    };
  }

  /// -------- UI Calculations --------

  IconData get iconData => habitIcons[iconIndex];

  Color get color => Color(colorHex);

  bool get isCompletedToday {
    if (lastCompletedAt == null) return false;
    final now = DateTime.now();
    return now.year == lastCompletedAt!.year &&
        now.month == lastCompletedAt!.month &&
        now.day == lastCompletedAt!.day;
  }

  int get currentStreak => streak;

  int get completedCount => 0; // you can store future analytics
  int get skippedCount => 0;
  int get bestStreak => streak;

  double get successRate => 0;
}
