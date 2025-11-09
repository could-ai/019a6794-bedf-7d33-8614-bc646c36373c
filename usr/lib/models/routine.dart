class Routine {
  final String id;
  final String title;
  final String? description;
  final TimeOfDay time;
  final List<bool> completedDays; // Son 7 gün için tamamlanma durumu
  final String icon;
  final bool isCompleted;

  Routine({
    required this.id,
    required this.title,
    this.description,
    required this.time,
    required this.completedDays,
    required this.icon,
    this.isCompleted = false,
  });

  Routine copyWith({
    String? id,
    String? title,
    String? description,
    TimeOfDay? time,
    List<bool>? completedDays,
    String? icon,
    bool? isCompleted,
  }) {
    return Routine(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      completedDays: completedDays ?? this.completedDays,
      icon: icon ?? this.icon,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}