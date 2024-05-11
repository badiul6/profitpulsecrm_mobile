class Ticket {
  String status;
  String issue;
  List<String> progress;
  TicketUser user;
  TicketContact contact;
  String ticketNo;
  final DateTime updatedAt;


  Ticket({
    required this.status,
    required this.issue,
    required this.progress,
    required this.user,
    required this.contact,
    required this.ticketNo,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    List<String> progress = List<String>.from(json['progress']);
    return Ticket(
      status: json['status'],
      issue: json['issue'],
      progress: progress,
      user: TicketUser.fromJson(json['user']),
      contact: TicketContact.fromJson(json['contact']),
      ticketNo: json['ticketNo'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
class TicketContact {
  String email;
  String fullname;
  String phone;
  String? companyname; // companyname can be nullable
  String creater;
  String? jobtitle; // companyname can be nullable


  TicketContact({
    required this.email,
    required this.fullname,
    required this.phone,
    this.companyname,
    this.jobtitle,
    required this.creater,
  });

  factory TicketContact.fromJson(Map<String, dynamic> json) {
    return TicketContact(
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      companyname: json['companyname'],
      jobtitle: json['jobtitle'],
      creater: json['creater'],
    );
  }
}

class TicketUser {
  String email;
  String fullname;

  TicketUser({
    required this.email,
    required this.fullname,
  });

  factory TicketUser.fromJson(Map<String, dynamic> json) {
    return TicketUser(
      email: json['email'],
      fullname: json['fullname'],
    );
  }
}
