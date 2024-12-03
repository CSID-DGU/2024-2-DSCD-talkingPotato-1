class DrugBriefState {
  final int id;
  final String name;
  final String type;

  DrugBriefState({
    required this.id,
    required this.name,
    required this.type,
  });

  factory DrugBriefState.fromJson(Map<String, dynamic> json) {
    return DrugBriefState(
      id: json['id'],
      name: json['name'],
      type: json['type'] == 'VITAMIN' ? 'VITAMIN' : 'MEDICINE',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}
