class LoginResponse {
  final String message;
  final bool isCompleted;
  final List<String> roles;

  LoginResponse({
    required this.message,
    required this.isCompleted,
    required this.roles,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      isCompleted: json['isCompleted'],
      roles: List<String>.from(json['roles']),
    );
  }
}
