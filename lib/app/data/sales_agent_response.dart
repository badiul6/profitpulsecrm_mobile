class SalesAgentResponse {
  final String email;
  final String fullname;

  SalesAgentResponse({required this.email, required this.fullname});

  // Factory constructor for creating a new User instance from a map.
  factory SalesAgentResponse.fromJson(Map<String, dynamic> json) {
    return SalesAgentResponse(
      email: json['email'],
      fullname: json['fullname'],
    );
  }
}
