import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../models/block.dart';
import '../widgets/block_card.dart';

class FarmsScreen extends StatefulWidget {
  const FarmsScreen({super.key});
  @override
  State<FarmsScreen> createState() => _FarmsScreenState();
}

class _FarmsScreenState extends State<FarmsScreen> {
  String _search = '';
  String? _filterVariety;

  static const _varieties = [
    null, 'Gewurztraminer', 'Assyrtiko', 'Merlot', 'Chardonnay'
  ];

  List<Block> get _filtered {
    return Block.mockBlocks.where((b) {
      final matchesSearch = _search.isEmpty ||
          b.name.toLowerCase().contains(_search.toLowerCase()) ||
          b.variety.toLowerCase().contains(_search.toLowerCase()) ||
          b.farm.toLowerCase().contains(_search.toLowerCase());
      final matchesVariety =
          _filterVariety == null || b.variety == _filterVariety;
      return matchesSearch && matchesVariety;
    }).toList();
  }

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            children: const [
                              Text(
                                'Farms & Blocks',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'KOKOTOS ESTATE',
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
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '🔍 Search blocks, varieties…',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Variety filter pills
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _varieties.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final v = _varieties[i];
                final label = v ?? 'All';
                final isSelected = _filterVariety == v;
                return GestureDetector(
                  onTap: () => setState(() => _filterVariety = v),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: isSelected
                          ? null
                          : Border.all(color: AppColors.divider),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Block list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => BlockCard(
                block: _filtered[i],
                onTap: () => context.go('/farms/${_filtered[i].id}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
