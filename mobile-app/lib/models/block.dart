class Block {
  final String id;
  final String name;
  final String variety;
  final String farm;
  final double hectares;
  final double? latitude;
  final double? longitude;
  final String phenologyStage;
  final double? ndvi;
  final double? canopyCoverage;
  final int flightCount;
  final DateTime? lastFlight;

  const Block({
    required this.id,
    required this.name,
    required this.variety,
    required this.farm,
    required this.hectares,
    this.latitude,
    this.longitude,
    required this.phenologyStage,
    this.ndvi,
    this.canopyCoverage,
    required this.flightCount,
    this.lastFlight,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        variety: json['variety']?.toString() ?? '',
        farm: json['farm']?.toString() ?? '',
        hectares: (json['hectares'] as num?)?.toDouble() ?? 0,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        phenologyStage: json['phenology_stage']?.toString() ?? 'Unknown',
        ndvi: (json['ndvi'] as num?)?.toDouble(),
        canopyCoverage: (json['canopy_coverage'] as num?)?.toDouble(),
        flightCount: (json['flight_count'] as num?)?.toInt() ?? 0,
        lastFlight: json['last_flight'] != null
            ? DateTime.tryParse(json['last_flight'].toString())
            : null,
      );

  String get lastFlightLabel {
    if (lastFlight == null) return 'No flights';
    final diff = DateTime.now().difference(lastFlight!);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays}d ago';
  }

  // Mock data for UI development while API is being connected
  static List<Block> mockBlocks = [
    const Block(
      id: 'A1', name: 'Block A1', variety: 'Gewurztraminer',
      farm: 'North Farm', hectares: 2.4,
      latitude: 37.9808, longitude: 23.7281,
      phenologyStage: 'Berry Dev.', ndvi: 0.72,
      canopyCoverage: 84, flightCount: 12,
    ),
    const Block(
      id: 'A2', name: 'Block A2', variety: 'Assyrtiko',
      farm: 'North Farm', hectares: 1.8,
      latitude: 37.9812, longitude: 23.7290,
      phenologyStage: 'Veraison', ndvi: 0.68,
      canopyCoverage: 79, flightCount: 9,
    ),
    const Block(
      id: 'B1', name: 'Block B1', variety: 'Merlot',
      farm: 'South Farm', hectares: 3.1,
      latitude: 37.9795, longitude: 23.7265,
      phenologyStage: 'Flowering', ndvi: 0.61,
      canopyCoverage: 71, flightCount: 7,
    ),
    const Block(
      id: 'B3', name: 'Block B3', variety: 'Chardonnay',
      farm: 'South Farm', hectares: 2.7,
      latitude: 37.9788, longitude: 23.7258,
      phenologyStage: 'Fruit Set', ndvi: 0.58,
      canopyCoverage: 65, flightCount: 5,
    ),
  ];
}
