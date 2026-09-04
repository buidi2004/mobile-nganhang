import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = true;
  int _selectedWallpaperIdx = 0;
  String _selectedLanguage = 'Tiếng Việt';
  bool _notificationSound = true;

  final List<String> _wallpapers = [
    'Hoa Sen Cung Đình',
    'Đêm Phố Cổ Hà Nội',
    'Sơn Trà Đà Nẵng',
    'Hoàng Hôn Sài Gòn',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cài Đặt Ứng Dụng'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Giao diện & Trải nghiệm', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: _isDarkMode,
                    activeTrackColor: AppColors.primary,
                    title: Text('Chế độ Tối (Dark Theme)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Tối ưu hóa hiển thị thẻ kính mờ Liquid Glass', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _isDarkMode = v),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  SwitchListTile.adaptive(
                    value: _notificationSound,
                    activeTrackColor: AppColors.primary,
                    title: Text('Âm thanh thông báo tiền vào', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Phát âm báo "Ting Ting" khi nhận tiền', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _notificationSound = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Hình nền nghệ thuật cá nhân hóa', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_wallpapers.length, (idx) {
                  final wp = _wallpapers[idx];
                  final isSelected = _selectedWallpaperIdx == idx;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () => setState(() => _selectedWallpaperIdx = idx),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.cardDark,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.cardBorderDark,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: idx == 0
                                      ? [const Color(0xFF0077B6), const Color(0xFF26E5DC)]
                                      : (idx == 1
                                          ? [const Color(0xFF1E3A8A), const Color(0xFF0F172A)]
                                          : [const Color(0xFF059669), const Color(0xFF064E3B)]),
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: isSelected
                                    ? const Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.white, size: 28)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              wp,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isSelected ? AppColors.primaryLight : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),
            Text('Ngôn ngữ hiển thị', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Material(type: MaterialType.transparency, child: ListTile(
                leading: const Icon(CupertinoIcons.globe, color: AppColors.primary),
                title: Text('Ngôn ngữ', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: AppColors.cardDark,
                  underline: const SizedBox(),
                  style: const TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                  items: ['Tiếng Việt', 'English', '日本語'].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLanguage = val);
                  },
                ),
              )),
            ),

            const SizedBox(height: 24),
            Text('Nhà phát triển & Hệ thống', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Material(type: MaterialType.transparency, child: ListTile(
                onTap: () => context.push('/settings/config'),
                leading: const Icon(CupertinoIcons.gear_alt_fill, color: AppColors.accentGold),
                title: Text('Cấu hình API Backend', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                subtitle: Text('Đổi URL Server máy chủ dev / staging / prod', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
