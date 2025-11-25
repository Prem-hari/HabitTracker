// lib/screens/habit_detail_screen.dart
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/habit.dart';
import '../services/habit_service.dart';

class HabitDetailScreen extends ConsumerWidget {
  final Habit habit;
  const HabitDetailScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.read(habitServiceProvider);
    final isDoneToday = habit.isCompletedToday;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      body: SafeArea(
        child: Column(
          children: [
            _HeaderSection(habit: habit),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatGrid(habit: habit),
                    const SizedBox(height: 20),
                    const _Last7Weeks(),
                    const SizedBox(height: 20),
                    _Insights(habit: habit),
                    const SizedBox(height: 30),
                    _CompleteButton(
                      enabled: !isDoneToday,
                      onTap: () async {
                        await service.markDoneToday(habit);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "🔥 '${habit.name}' completed! Streak increased!"),
                            backgroundColor: Colors.green.shade400,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final Habit habit;
  const _HeaderSection({required this.habit});

  @override
  Widget build(BuildContext context) {
    final streak = habit.currentStreak;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          // icon block
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEAE1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(habit.iconData, size: 40, color: Colors.orange),
          ),
          const SizedBox(width: 14),

          // title column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7CAB4),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(
                      " $streak day streak",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class _StatGrid extends StatelessWidget {
  final Habit habit;
  const _StatGrid({required this.habit});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        _statCard("Completed", habit.completedCount.toString(),
            Icons.track_changes, Colors.green),
        _statCard("Success Rate", "${habit.successRate.toStringAsFixed(1)}%",
            Icons.trending_up, Colors.blue),
        _statCard("Best Streak", habit.bestStreak.toString(),
            Icons.local_fire_department, Colors.deepOrange),
        _statCard("Skipped", habit.skippedCount.toString(), Icons.close,
            Colors.grey),
      ],
    );
  }

  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
class _Last7Weeks extends StatelessWidget {
  const _Last7Weeks();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📅 Last 7 Weeks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),

        // simple weekly grid
        SizedBox(
          height: 180,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 49, // 7x7
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (_, i) {
              return Container(
                decoration: BoxDecoration(
                  color: i % 3 == 0
                      ? Colors.green.shade300
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
class _Insights extends StatelessWidget {
  final Habit habit;
  const _Insights({required this.habit});

  Widget _tip(String text, {Color? bg}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: bg ?? Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Insights",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        _tip("You've completed this habit ${habit.completedCount} times"),
        _tip("Amazing! You're on a ${habit.currentStreak}-day streak 🔥"),
        _tip("${habit.successRate}% success rate — Keep it up!",
            bg: Colors.green.shade50),
        _tip("Try to reduce skipped days to build consistency",
            bg: Colors.red.shade50),
      ],
    );
  }
}
class _CompleteButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _CompleteButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: enabled ? Colors.green : Colors.grey,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          enabled ? "Completed today!" : "Already completed",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: enabled ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
