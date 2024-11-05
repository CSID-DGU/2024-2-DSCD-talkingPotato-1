class SpeechToTextState {
  final bool isFirstListening;
  final bool isListening;
  final bool isCompleted;
  final String beforeSpeechText;
  final String afterSpeechText;

  SpeechToTextState({
    required this.isFirstListening,
    required this.isListening,
    required this.isCompleted,
    required this.beforeSpeechText,
    required this.afterSpeechText,
  });

  factory SpeechToTextState.initial() {
    return SpeechToTextState(
      isFirstListening: true,
      isListening: false,
      isCompleted: false,
      beforeSpeechText: '',
      afterSpeechText: '',
    );
  }

  SpeechToTextState copyWith({
    bool? isFirstListening,
    bool? isListening,
    bool? isCompleted,
    String? beforeSpeechText,
    String? afterSpeechText,
  }) {
    return SpeechToTextState(
      isFirstListening: isFirstListening ?? this.isFirstListening,
      isListening: isListening ?? this.isListening,
      isCompleted: isCompleted ?? this.isCompleted,
      beforeSpeechText: beforeSpeechText ?? this.beforeSpeechText,
      afterSpeechText: afterSpeechText ?? this.afterSpeechText,
    );
  }
}
