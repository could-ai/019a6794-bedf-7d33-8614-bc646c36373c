import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../widgets/routine_card.dart';
import '../widgets/add_routine_dialog.dart';
import '../widgets/stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Routine> routines = [
    Routine(
      id: '1',
      title: 'Sabah Meditasyonu',
      description: '10 dakika nefes egzersizi',
      time: const TimeOfDay(hour: 7, minute: 0),
      completedDays: [true, true, false, true, true, false, false],
      icon: '🧘',
    ),
    Routine(
      id: '2',
      title: 'Spor',
      description: '30 dakika egzersiz',
      time: const TimeOfDay(hour: 18, minute: 30),
      completedDays: [true, false, true, true, false, false, false],
      icon: '💪',
    ),
    Routine(
      id: '3',
      title: 'Kitap Okuma',
      description: '20 sayfa okumak',
      time: const TimeOfDay(hour: 21, minute: 0),
      completedDays: [false, true, true, false, true, false, false],
      icon: '📚',
    ),
  ];

  void _toggleRoutineCompletion(String id) {
    setState(() {
      final index = routines.indexWhere((r) => r.id == id);
      if (index != -1) {
        routines[index] = routines[index].copyWith(
          isCompleted: !routines[index].isCompleted,
        );
      }
    });
  }

  void _addRoutine(Routine routine) {
    setState(() {
      routines.add(routine);
    });
  }

  void _deleteRoutine(String id) {
    setState(() {
      routines.removeWhere((r) => r.id == id);
    });
  }

  void _showAddRoutineDialog() {
    showDialog(
      context: context,
      builder: (context) => AddRoutineDialog(
        onAdd: _addRoutine,
      ),
    );
  }

  int get completedToday {
    return routines.where((r) => r.isCompleted).length;
  }

  int get totalRoutines {
    return routines.length;
  }

  double get weeklyCompletionRate {
    if (routines.isEmpty) return 0;
    int totalCompleted = 0;
    int totalPossible = routines.length * 7;
    
    for (var routine in routines) {
      totalCompleted += routine.completedDays.where((d) => d).length;
    }
    
    return (totalCompleted / totalPossible) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Günlük Rutinlerim',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: routines.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_available,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz rutin eklenmemiş',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yeni bir rutin eklemek için + butonuna tıklayın',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatsCard(
                      completedToday: completedToday,
                      totalRoutines: totalRoutines,
                      weeklyCompletionRate: weeklyCompletionRate,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Bugünün Rutinleri',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: routines.length,
                      itemBuilder: (context, index) {
                        return RoutineCard(
                          routine: routines[index],
                          onToggle: () => _toggleRoutineCompletion(
                            routines[index].id,
                          ),
                          onDelete: () => _deleteRoutine(routines[index].id),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddRoutineDialog,
        icon: const Icon(Icons.add),
        label: const Text('Yeni Rutin'),
        elevation: 4,
      ),
    );
  }
}