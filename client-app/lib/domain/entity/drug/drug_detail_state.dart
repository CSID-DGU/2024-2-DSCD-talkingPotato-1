class DrugDetailState {
  final String effect;
  final String dosage;
  final String precaution;
  final List<String>? categories;
  final String? expirationDate;
  final String? storageMethod;

  DrugDetailState({
    required this.effect,
    required this.dosage,
    required this.precaution,
    this.categories,
    this.expirationDate,
    this.storageMethod,
  });

  factory DrugDetailState.initial() {
    return DrugDetailState(
      effect: '',
      dosage: '',
      precaution: '',
    );
  }

  factory DrugDetailState.fromJson(Map<String, dynamic> json) {
    return DrugDetailState(
      effect: json['effect'],
      dosage: json['dosage'],
      precaution: json['precaution'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : null,
      expirationDate: json['expiration_date'],
      storageMethod: json['storage_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'effect': effect,
      'dosage': dosage,
      'precaution': precaution,
      'categories': categories,
      'expiration_date': expirationDate,
      'storage_method': storageMethod,
    };
  }
}
