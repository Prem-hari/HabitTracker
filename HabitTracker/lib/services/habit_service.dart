// lib/services/habit_service.dart
// ignore_for_file: unused_import, implementation_imports, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/screens/auth_screen.dart';
import 'package:riverpod/src/framework.dart';

import '../models/habit.dart';
import 'auth_service.dart';

final firebaseDbProvider = Provider<FirebaseDatabase>((ref) {
  return FirebaseDatabase.instance;
});

class HabitService {
  final FirebaseDatabase _db;
  final FirebaseAuth _auth;

  HabitService(this._db, this._auth);

  DatabaseReference _userHabitsRef(String uid) =>
      _db.ref('users/$uid/habits');

  Stream<List<Habit>> watchHabits() {
  final uid = _auth.currentUser?.uid;
  if (uid == null) return const Stream.empty();

  final ref = _db.ref('users/$uid/habits');

  return ref.onValue.map((event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>?;

    if (data == null) return [];

    return data.entries
        .map((e) => Habit.fromMap(e.key.toString(), e.value))
        .toList();
  });
}


  Future<void> addHabit({
  required String name,
  required int colorHex,
  required int iconCodePoint,
}) async {
  final uid = _auth.currentUser?.uid;
  if (uid == null) return;

  final ref = _db.ref('users/$uid/habits').push();
  await ref.set({
    'name': name,
    'colorHex': colorHex,
    'iconCode': iconCodePoint,
    'streak': 0,
    'lastCompletedAt': null,
  });
}


  /// Mark habit done for today and update streak
  Future<void> markDoneToday(Habit habit) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final now = DateTime.now();
    final todayString =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final last = habit.lastCompletedAt;
    String? lastString;
    if (last != null) {
      lastString =
          "${last.year}-${last.month.toString().padLeft(2, '0')}-${last.day.toString().padLeft(2, '0')}";
    }

    // already done today → no update
    if (lastString == todayString) {
      return;
    }

    int newStreak;
    if (last == null) {
      newStreak = 1;
    } else {
      final diffDays = now.difference(last).inDays;
      if (diffDays == 1) {
        newStreak = habit.streak + 1;
      } else {
        newStreak = 1;
      }
    }

    final ref = _userHabitsRef(uid).child(habit.id);
    await ref.update({
      'streak': newStreak,
      'lastCompletedAt': now.toIso8601String(),
    });
  }

  Future<void> deleteHabit(Habit habit) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _userHabitsRef(uid).child(habit.id).remove();
  }
}
/// Global service provider for habits
final habitServiceProvider = Provider<HabitService>((ref) {
  final db = ref.watch(firebaseDbProvider);
  final auth = ref.watch(firebaseAuthProvider); // comes from auth_service.dart
  return HabitService(db, auth);
});


