class DrugSummaryState {
  final int id;
  final String type;
  final String? imageUrl;
  final String classificationOrManufacturer;
  final String name;

  DrugSummaryState({
    required this.id,
    required this.type,
    required this.imageUrl,
    required this.classificationOrManufacturer,
    required this.name,
  });

  factory DrugSummaryState.initial() {
    return DrugSummaryState(
      id: 0,
      type: '',
      imageUrl: '',
      classificationOrManufacturer: '',
      name: '',
    );
  }

  factory DrugSummaryState.fromJson(Map<String, dynamic> json) {
    return DrugSummaryState(
      id: json['id'],
      type: json['type']! == 'VITAMIN' ? 'VITAMIN' : 'MEDICINE',
      imageUrl: json['image_url'],
      classificationOrManufacturer: json['classification_or_manufacturer'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'image_url': imageUrl,
      'classification_or_manufacturer': classificationOrManufacturer,
      'name': name,
    };
  }
}
