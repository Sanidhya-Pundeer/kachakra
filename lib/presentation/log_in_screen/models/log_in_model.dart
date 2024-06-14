class LogInModel {
  String userId;
  String name;
  String email;
  // Add other properties

  LogInModel({
    required this.userId,
    required this.name,
    required this.email,
    // Initialize other properties here
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      // Map other properties accordingly
    );
  }
}
