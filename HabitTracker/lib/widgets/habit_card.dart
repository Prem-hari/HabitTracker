// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/habit.dart';
import '../services/habit_service.dart';
import '../screens/habit_detail_screen.dart';

class HabitCard extends ConsumerWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitService = ref.read(habitServiceProvider);
    final bool done = habit.isCompletedToday;

    return GestureDetector(
      // Mark complete
      onTap: () async {
        await habitService.markDoneToday(habit);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("🔥 '${habit.name}' completed today!"),
            backgroundColor: Colors.green.shade400,
          ),
        );
      },

      // Open habit detail page
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HabitDetailScreen(habit: habit),
        ),
      ),

      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: done ? Colors.green : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: -1,
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ICON
            Icon(
              habit.iconData,
              size: 46,
              color: done ? Colors.green : Colors.grey.shade600,
            ),
            const SizedBox(height: 10),

            /// NAME
            Text(
              habit.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            /// STREAK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_fire_department,
                    color: Color(0xFFF39A7A), size: 20),
                const SizedBox(width: 4),
                Text(
                  habit.currentStreak.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFF39A7A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
