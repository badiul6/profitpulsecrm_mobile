class Campaign {
  final String name;
  final int totalEmailsSent;
  final int clicks;

  Campaign({
    required this.name,
    required this.totalEmailsSent,
    required this.clicks,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      name: json['name'],
      totalEmailsSent: json['totalEmailsSent'],
      clicks: json['clicks'],
    );
  }
}
