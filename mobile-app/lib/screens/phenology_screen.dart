import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../models/pest_risk.dart';

/// Phenology tab — growth phases for the season, each one linked to the
/// drone flight window that scouts it, per the agriculturalist's rules
/// spreadsheet ("Rules for NDVI Estate Kokotos.xlsx"). The 6 flight
/// windows use the same dates across every block, so this screen shows
/// the estate-wide calendar; tapping a phase jumps to Flights to review
/// that window's drone imagery.
class PhenologyScreen extends StatelessWidget {
  const PhenologyScreen({super.key});

  // Estate-wide flight calendar. The date ranges and growth stages are
  // identical for every block in the spreadsheet — only the per-block
  // disease/pest lists differ (shown on each block's own detail page).
  // We use Block '1' (Chardonnay) here purely as the source of the
  // shared calendar.
  static List<FlightRiskWindow> get _windows =>
      BlockPestRisk.forBlock('1')?.windows ?? const [];

  static const _phaseEmoji = {
    'Budburst to Early Shoot Growth': '🌱',
    'Leaf Development': '🌿',
    'Pre-Bloom to Flowering': '🌸',
    'Fruit Set to Bunch Closure': '🍇',
    'Veraison': '🟣',
    'Veraison to Harvest': '✂️',
  };

  @override
  Widget build(BuildContext context) {
    final windows = _windows;

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
                    'Linked to flight windows · Rules for NDVI Estate Kokotos',
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
                // Dormancy — before the flight season begins, no flight
                // window covers it.
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Text('💤', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dormancy',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Before the flight season begins — no scouting flight',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // One card per flight window / growth phase.
                for (final w in windows) _PhaseCard(window: w, emoji: _phaseEmoji[w.growthStage] ?? '🍃'),

                const SizedBox(height: 8),
                const Text(
                  'Disease/pest risks shown per phase are the estate-wide '
                  'rules from the agriculturalist\'s spreadsheet. Open a block '
                  'under Farms for that block\'s specific risk list.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final FlightRiskWindow window;
  final String emoji;
  const _PhaseCard({required this.window, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      window.growthStage,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      window.flightLabel,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint15,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  window.elStage,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: window.risks
                .map((r) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.goldTint,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        r,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          color: AppColors.gold,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => context.go('/flights'),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'View drone images for this window',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryLight,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 12, color: AppColors.primaryLight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
