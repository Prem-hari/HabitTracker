// lib/screens/habit_list_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/habit.dart';
import '../providers/habit_providers.dart';
import '../services/habit_service.dart';

import 'add_habit_screen.dart';
import 'habit_detail_screen.dart';
import 'profile_sheet.dart';
import 'profile_screen.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsStreamProvider);

    return habitsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (habits) {
  if (habits.isEmpty) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Welcome! Start by creating your first habit 🚀",
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddHabitScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
  return _HomeContent(habits: habits);
},
    );
  }
}

class _HomeContent extends ConsumerWidget {
  final List<Habit> habits;
  const _HomeContent({required this.habits});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayDone = habits.where((h) => h.isCompletedToday).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Habits",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const ProfileSheet(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Color(0xFFF39A7A),
                          size: 32,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddHabitScreen(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 6),
              const Text(
                "Keep the momentum going",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              /// STATS
              Row(
                children: [
                  _stat("Today", "$todayDone/${habits.length}"),
                  const SizedBox(width: 12),
                  _stat("Total Streak", _totalStreak(habits).toString()),
                ],
              ),

              const SizedBox(height: 20),

              /// HABIT GRID
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: habits.length,
                padding: const EdgeInsets.only(bottom: 100),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (_, i) => _HabitCard(habit: habits[i]),
              ),
            ],
          ),
        ),
      ),

      /// bottom nav only on home
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // already home
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddHabitScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _stat(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.grey, fontSize: 15)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _totalStreak(List<Habit> all) =>
      all.fold(0, (sum, h) => sum + h.currentStreak);
}

class _HabitCard extends ConsumerWidget {
  final Habit habit;
  const _HabitCard({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.read(habitServiceProvider);
    final done = habit.isCompletedToday;

    return GestureDetector(
      /// tap → open dashboard
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HabitDetailScreen(habit: habit),
          ),
        );
      },

      /// long press → quick complete
      onLongPress: () async {
        await service.markDoneToday(habit);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("🔥 '${habit.name}' completed today!"),
            backgroundColor: Colors.green.shade300,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: done ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              habit.iconData,
              size: 44,
              color: done ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              habit.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Color(0xFFF39A7A),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  habit.currentStreak.toString(),
                  style: const TextStyle(
                    color: Color(0xFFF39A7A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
