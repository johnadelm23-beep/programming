class AIQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  AIQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory AIQuestion.fromJson(Map<String, dynamic> json) {
    return AIQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
    );
  }
}
