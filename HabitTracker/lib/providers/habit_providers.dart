import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/habit_service.dart';
import '../models/habit.dart';

final habitsStreamProvider = StreamProvider<List<Habit>>((ref) {
  final service = ref.watch(habitServiceProvider);
  return service.watchHabits();
});
