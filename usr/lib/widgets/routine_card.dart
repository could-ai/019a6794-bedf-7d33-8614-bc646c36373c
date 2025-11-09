import 'package:flutter/material.dart';
import '../models/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.onToggle,
    required this.onDelete,
  });

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: routine.isCompleted
                          ? Colors.green[100]
                          : Colors.purple[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      routine.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title and Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          routine.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: routine.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: routine.isCompleted
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        if (routine.description != null) ..[
                          const SizedBox(height: 4),
                          Text(
                            routine.description!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Time
                  Column(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(routine.time),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Checkbox
                  Checkbox(
                    value: routine.isCompleted,
                    onChanged: (value) => onToggle(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[400],
                    onPressed: onDelete,
                    iconSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Weekly Progress
              Row(
                children: [
                  Text(
                    'Son 7 gün:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: List.generate(
                        7,
                        (index) => Expanded(
                          child: Container(
                            height: 8,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: routine.completedDays[index]
                                  ? Colors.green
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}