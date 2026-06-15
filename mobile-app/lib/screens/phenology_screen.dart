import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class PhenologyScreen extends StatelessWidget {
  const PhenologyScreen({super.key});

  static const _stages = [
    _Stage('💤', 'Dormancy', 'Complete', true, false),
    _Stage('🌱', 'Budbreak', 'Complete', true, false),
    _Stage('🌸', 'Flowering', 'Complete', true, false),
    _Stage('🍇', 'Berry Dev.', 'In Progress', true, true),
    _Stage('🟣', 'Veraison', 'Upcoming', false, false),
    _Stage('✂️', 'Harvest', 'Upcoming', false, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.surface,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 12,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    'Phenology Tracking',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2025 Growing Season',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Timeline
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left stages (even indices)
                    Expanded(
                      child: Column(
                        children: [
                          for (int i = 0; i < _stages.length; i += 2) ...[
                            if (i ~/ 2 > 0) const SizedBox(height: 44),
                            _StageCard(stage: _stages[i], alignRight: true),
                          ],
                        ],
                      ),
                    ),

                    // Center timeline
                    SizedBox(
                      width: 36,
                      child: Column(
                        children: [
                          for (int i = 0; i < _stages.length; i++) ...[
                            _StageNode(stage: _stages[i]),
                            if (i < _stages.length - 1)
                              Container(
                                width: 2,
                                height: 44,
                                color: _stages[i].isComplete
                                    ? AppColors.primary
                                    : AppColors.divider,
                              ),
                          ],
                        ],
                      ),
                    ),

                    // Right stages (odd indices)
                    Expanded(
                      child: Column(
                        children: [
                          for (int i = 1; i < _stages.length; i += 2) ...[
                            if ((i - 1) ~/ 2 > 0) const SizedBox(height: 44),
                            const SizedBox(height: 36 + 44), // align to matching node
                            _StageCard(stage: _stages[i], alignRight: false),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Detail card — current stage
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🍇 Berry Development',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Stage 4 of 6 · Started Jun 28',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Metrics row
                      Row(
                        children: [
                          _MetricTile(label: 'NDVI Index', value: '0.72', delta: '▲ +3%', positive: true),
                          _MetricTile(label: 'Canopy Coverage', value: '84%', delta: '▲ +1%', positive: true),
                          _MetricTile(label: 'Estimated Yield', value: '4.2 t/ha', delta: '— Stable', positive: null),
                        ],
                      ),
                      const Divider(height: 24),
                      const Text(
                        'Next: Veraison expected ~Jul 18',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Phenology API · port 8002 · private-4',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stage {
  final String emoji;
  final String name;
  final String status;
  final bool isComplete;
  final bool isActive;
  const _Stage(this.emoji, this.name, this.status, this.isComplete, this.isActive);
}

class _StageNode extends StatelessWidget {
  final _Stage stage;
  const _StageNode({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: stage.isActive
            ? AppColors.primary
            : stage.isComplete
                ? AppColors.primaryTint20
                : AppColors.divider,
        shape: BoxShape.circle,
        border: stage.isActive
            ? Border.all(color: AppColors.primaryLight, width: 2)
            : null,
      ),
      child: Center(
        child: Text(stage.emoji,
            style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final _Stage stage;
  final bool alignRight;
  const _StageCard({required this.stage, required this.alignRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: alignRight
          ? const EdgeInsets.only(right: 4)
          : const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: stage.isActive ? AppColors.primaryTint15 : AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: stage.isActive
            ? Border.all(color: AppColors.primary, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: alignRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            stage.name,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: stage.isActive
                  ? AppColors.primaryLight
                  : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stage.status,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              color: stage.isActive
                  ? AppColors.primaryLight
                  : stage.isComplete
                      ? AppColors.textSecondary
                      : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final bool? positive;
  const _MetricTile({
    required this.label,
    required this.value,
    required this.delta,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    final deltaColor = positive == null
        ? AppColors.textSecondary
        : positive!
            ? AppColors.primaryLight
            : AppColors.error;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                fontFamily: 'Inter', fontSize: 10, color: AppColors.textMuted)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
          const SizedBox(height: 2),
          Text(delta,
              style: TextStyle(
                fontFamily: 'Inter', fontSize: 10, color: deltaColor)),
        ],
      ),
    );
  }
}
