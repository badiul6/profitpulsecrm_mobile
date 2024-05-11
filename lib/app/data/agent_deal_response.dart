class AgentDeal {
  final String status;
  final List<String> interactions;
  final AgentDealContact contact;
  final bool isActive;
  final DateTime updatedAt;

  AgentDeal({
    required this.status,
    required this.interactions,
    required this.contact,
    required this.isActive,
    required this.updatedAt,
  });

  factory AgentDeal.fromJson(Map<String, dynamic> json) {
    var interactionList = List<String>.from(json['interactions']);
    return AgentDeal(
      status: json['status'],
      interactions: interactionList,
      contact: AgentDealContact.fromJson(json['contact']),
      isActive: json['isActive'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class AgentDealContact {
  final String email;
  final String fullname;
  final String phone;
  final String? companyname;
  final String? jobtitle; // Newly added nullable field

  AgentDealContact({
    required this.email,
    required this.fullname,
    required this.phone,
    this.companyname,
    this.jobtitle, // Made nullable
  });

  factory AgentDealContact.fromJson(Map<String, dynamic> json) {
    return AgentDealContact(
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      companyname: json['companyname'],
      jobtitle: json['jobtitle'], // Might be null
    );
  }
}

