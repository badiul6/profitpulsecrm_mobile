class Deal {
  final String status;
  final List<String> interactions;
  final DealContact contact;
  final DealUser user;
  final bool isActive;
  final DateTime updatedAt;

  Deal({
    required this.status,
    required this.interactions,
    required this.contact,
    required this.user,
    required this.isActive,
    required this.updatedAt,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    var interactionList = List<String>.from(json['interactions']);
    return Deal(
      status: json['status'],
      interactions: interactionList,
      contact: DealContact.fromJson(json['contact']),
      user: DealUser.fromJson(json['user']),
      isActive: json['isActive'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class DealContact {
  final String email;
  final String fullname;
  final String phone;
  final String? companyname;
  final String creater;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? jobtitle; // Newly added nullable field

  DealContact({
    required this.email,
    required this.fullname,
    required this.phone,
    this.companyname,
    required this.creater,
    required this.createdAt,
    required this.updatedAt,
    this.jobtitle, // Made nullable
  });

  factory DealContact.fromJson(Map<String, dynamic> json) {
    return DealContact(
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      companyname: json['companyname'],
      jobtitle: json['jobtitle'], // Might be null
      creater: json['creater'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class DealUser {
  final String email;
  final String fullname;
  final bool isVerified;

  DealUser({
    required this.email,
    required this.fullname,
    required this.isVerified,
  });

  factory DealUser.fromJson(Map<String, dynamic> json) {
    return DealUser(
      email: json['email'],
      fullname: json['fullname'],
      isVerified: json['isVerified'],
    );
  }
}
