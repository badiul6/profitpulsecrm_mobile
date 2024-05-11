class Contact {
  final String email;
  final String fullname;
  final String phone;
  final String? companyname;
  final String creater;
  final DateTime createdAt;
  final String? jobtitle;  // Optional field

  Contact({
    required this.email,
    required this.fullname,
    required this.phone,
     this.companyname,
    required this.creater,
    required this.createdAt,
    this.jobtitle,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      companyname: json['companyname'],
      creater: json['creater'],
      createdAt: DateTime.parse(json['createdAt']),
      jobtitle: json['jobtitle'],
    );
  }
}
