class Agent {
  final String email;
  final String fullname;
  List<String> roles;

  Agent({required this.email, required this.fullname, required this.roles});

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      email: json['email'],
      fullname: json['fullname'],
      roles: List<String>.from(json['roles']),
    );
  }
}
