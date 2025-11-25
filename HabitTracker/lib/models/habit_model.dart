import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String name;
  final int iconCode;
  final int colorHex;
  final DateTime? lastCompletedAt;
  final int streak;

  Habit({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.colorHex,
    required this.streak,
    required this.lastCompletedAt,
  });

  /// HELPERS 👉 avoids null crash

  bool get isCompletedToday {
    if (lastCompletedAt == null) return false;
    final now = DateTime.now();
    return lastCompletedAt!.year == now.year &&
        lastCompletedAt!.month == now.month &&
        lastCompletedAt!.day == now.day;
  }

  int get currentStreak => streak;

  IconData get iconData => IconData(
        iconCode,
        fontFamily: 'MaterialIcons',
      );

  /// COLOR
  Color get color => Color(colorHex);

  factory Habit.fromMap(String id, Map<dynamic, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'] ?? 'Habit',
      iconCode: map['iconCode'] ?? 0,
      colorHex: map['colorHex'] ?? 0xffaaaaaa,
      streak: map['streak'] ?? 0,
      lastCompletedAt: map['lastCompletedAt'] != null
          ? DateTime.tryParse(map['lastCompletedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCode': iconCode,
      'colorHex': colorHex,
      'streak': streak,
      'lastCompletedAt': lastCompletedAt?.toIso8601String(),
    };
  }
}
