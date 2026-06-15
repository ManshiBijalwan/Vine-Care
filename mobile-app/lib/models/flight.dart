class DroneFlightStatus { static const processed = 'Processed'; static const pending = 'Pending'; static const failed = 'Failed'; }

class DroneFlight {
  final String id;
  final String blockId;
  final String blockName;
  final String variety;
  final int imageCount;
  final String status;
  final DateTime date;
  final double? ndvi;
  final double altitudeMeters;
  final String? s3Key;
  final String? operatorNotes;

  const DroneFlight({
    required this.id,
    required this.blockId,
    required this.blockName,
    required this.variety,
    required this.imageCount,
    required this.status,
    required this.date,
    this.ndvi,
    required this.altitudeMeters,
    this.s3Key,
    this.operatorNotes,
  });

  factory DroneFlight.fromJson(Map<String, dynamic> json) => DroneFlight(
        id: json['id']?.toString() ?? '',
        blockId: json['block_id']?.toString() ?? '',
        blockName: json['block_name']?.toString() ?? '',
        variety: json['variety']?.toString() ?? '',
        imageCount: (json['image_count'] as num?)?.toInt() ?? 0,
        status: json['status']?.toString() ?? 'Pending',
        date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
        ndvi: (json['ndvi'] as num?)?.toDouble(),
        altitudeMeters: (json['altitude_meters'] as num?)?.toDouble() ?? 50,
        s3Key: json['s3_key']?.toString(),
        operatorNotes: json['operator_notes']?.toString(),
      );

  String get dateLabel {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'Today, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    if (diff.inDays == 1) return 'Yesterday';
    return '${date.day} ${_months[date.month - 1]}, ${date.year}';
  }

  static const _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  static List<DroneFlight> mockFlights = [
    DroneFlight(
      id: 'f1', blockId: 'A1', blockName: 'Block A1', variety: 'Assyrtiko',
      imageCount: 87, status: DroneFlightStatus.processed,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      ndvi: 0.72, altitudeMeters: 50,
      s3Key: 'vine-care-bucket/flights/A1/2025-08-14',
    ),
    DroneFlight(
      id: 'f2', blockId: 'B3', blockName: 'Block B3', variety: 'Merlot',
      imageCount: 54, status: DroneFlightStatus.pending,
      date: DateTime.now().subtract(const Duration(days: 1)),
      altitudeMeters: 45,
    ),
    DroneFlight(
      id: 'f3', blockId: 'A1', blockName: 'Block A1', variety: 'Gewurztraminer',
      imageCount: 92, status: DroneFlightStatus.processed,
      date: DateTime(2025, 8, 7), ndvi: 0.69, altitudeMeters: 50,
      s3Key: 'vine-care-bucket/flights/A1/2025-08-07',
    ),
    DroneFlight(
      id: 'f4', blockId: 'A1', blockName: 'Block A1', variety: 'Gewurztraminer',
      imageCount: 74, status: DroneFlightStatus.processed,
      date: DateTime(2025, 7, 30), ndvi: 0.65, altitudeMeters: 50,
      s3Key: 'vine-care-bucket/flights/A1/2025-07-30',
    ),
  ];
}
