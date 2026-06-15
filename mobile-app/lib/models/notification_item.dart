class VineNotification {
  final String id;
  final String title;
  final String body;
  final String type; // 'alert' | 'phenology' | 'flight' | 'system'
  final bool isRead;
  final DateTime timestamp;

  const VineNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });

  factory VineNotification.fromJson(Map<String, dynamic> json) => VineNotification(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        body: json['body']?.toString() ?? '',
        type: json['type']?.toString() ?? 'system',
        isRead: json['is_read'] == true,
        timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ?? DateTime.now(),
      );

  String get timeLabel {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  String get icon {
    switch (type) {
      case 'alert': return '⚠️';
      case 'phenology': return '🍇';
      case 'flight': return '🚁';
      case 'system': return '✅';
      default: return '📊';
    }
  }

  static List<VineNotification> mockNotifications = [
    VineNotification(
      id: 'n1', title: 'Low NDVI Detected', isRead: false,
      body: 'Block B3 (Chardonnay) — NDVI dropped below 0.60 threshold',
      type: 'alert', timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    VineNotification(
      id: 'n2', title: 'Heat Stress Risk', isRead: false,
      body: 'Temperature >35°C forecast for next 3 days. Consider irrigation.',
      type: 'alert', timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    VineNotification(
      id: 'n3', title: 'Phenology Update', isRead: false,
      body: 'Veraison detected in Block A2 — Assyrtiko. Schedule harvest assessment.',
      type: 'phenology', timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    VineNotification(
      id: 'n4', title: 'Flight Completed', isRead: true,
      body: 'Block A1 drone flight processed. 87 images indexed in S3.',
      type: 'flight', timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    VineNotification(
      id: 'n5', title: 'KPI Report Ready', isRead: true,
      body: 'Weekly agronomic report available. Yield forecast: 4.2 t/ha.',
      type: 'system', timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    VineNotification(
      id: 'n6', title: 'System Health', isRead: true,
      body: 'All 3 backend microservices operational. Database available.',
      type: 'system', timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
