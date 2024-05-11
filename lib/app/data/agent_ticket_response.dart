class AgentTicket {
  String status;
  String issue;
  List<String> progress;
  AgentTicketUser user;
  AgentTicketContact contact;
  String ticketNo;
  final DateTime updatedAt;


  AgentTicket({
    required this.status,
    required this.issue,
    required this.progress,
    required this.user,
    required this.contact,
    required this.ticketNo,
    required this.updatedAt,
  });

  factory AgentTicket.fromJson(Map<String, dynamic> json) {
    List<String> progress = List<String>.from(json['progress']);
    return AgentTicket(
      status: json['status'],
      issue: json['issue'],
      progress: progress,
      user: AgentTicketUser.fromJson(json['user']),
      contact: AgentTicketContact.fromJson(json['contact']),
      ticketNo: json['ticketNo'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
class AgentTicketContact {
  String email;
  String fullname;
  String phone;
  String? companyname; // companyname can be nullable
  String creater;
  String? jobtitle; // companyname can be nullable


  AgentTicketContact({
    required this.email,
    required this.fullname,
    required this.phone,
    this.companyname,
    this.jobtitle,
    required this.creater,
  });

  factory AgentTicketContact.fromJson(Map<String, dynamic> json) {
    return AgentTicketContact(
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      companyname: json['companyname'],
      jobtitle: json['jobtitle'],
      creater: json['creater'],
    );
  }
}

class AgentTicketUser {
  String email;
  String fullname;

  AgentTicketUser({
    required this.email,
    required this.fullname,
  });

  factory AgentTicketUser.fromJson(Map<String, dynamic> json) {
    return AgentTicketUser(
      email: json['email'],
      fullname: json['fullname'],
    );
  }
}
