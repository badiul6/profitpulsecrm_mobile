class CampaignMetrics {
  final String impressions, reach, clicks, ctr, cpc, cpm, spend, costPerInlineLinkClick, frequency, campaignName, dateStart, dateStop;

  CampaignMetrics({
    required this.impressions,
    required this.reach,
    required this.clicks,
    required this.ctr,
    required this.cpc,
    required this.cpm,
    required this.spend,
    required this.costPerInlineLinkClick,
    required this.frequency,
    required this.campaignName,
    required this.dateStart,
    required this.dateStop,
  });

  factory CampaignMetrics.fromJson(Map<String, dynamic> json) {
    return CampaignMetrics(
      impressions: json['impressions'],
      reach: json['reach'],
      clicks: json['clicks'],
      ctr: json['ctr'],
      cpc: json['cpc'],
      cpm: json['cpm'],
      spend: json['spend'],
      costPerInlineLinkClick: json['cost_per_inline_link_click'],
      frequency: json['frequency'],
      campaignName: json['campaign_name'],
      dateStart: json['date_start'],
      dateStop: json['date_stop'],
    );
  }
}

class DayStat {
  final String date;
  final String value;

  DayStat({required this.date, required this.value});

  factory DayStat.fromJson(Map<String, dynamic> json) {
    return DayStat(
      date: json['date'].toString(),
      value: json['clicks'] ?? json['impressions'],
    );
  }
}
