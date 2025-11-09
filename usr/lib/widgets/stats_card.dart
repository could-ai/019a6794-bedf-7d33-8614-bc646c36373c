import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final int completedToday;
  final int totalRoutines;
  final double weeklyCompletionRate;

  const StatsCard({
    super.key,
    required this.completedToday,
    required this.totalRoutines,
    required this.weeklyCompletionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.today,
                  label: 'Bugün',
                  value: '$completedToday/$totalRoutines',
                  color: Colors.blue,
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey[300],
                ),
                _StatItem(
                  icon: Icons.calendar_week,
                  label: 'Haftalık',
                  value: '${weeklyCompletionRate.toStringAsFixed(0)}%',
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: completedToday / (totalRoutines > 0 ? totalRoutines : 1),
              backgroundColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}