class Profile {
  String companyName;
  String userName;
  String companyEmail;
  String role;
  String logo;  // Assuming this is a base64 encoded image string

  Profile({
    required this.companyName,
    required this.userName,
    required this.companyEmail,
    required this.role,
    required this.logo,
  });

  // Factory constructor to create a Company instance from a map
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      companyName: json['company_name'],
      userName: json['user_name'],
      companyEmail: json['company_email'],
      role: json['role'],
      logo: json['logo'],
    );
  }
}
