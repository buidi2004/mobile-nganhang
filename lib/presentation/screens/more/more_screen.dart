import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Menu Tiện Ích'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
          child: Column(
            children: [
              // User Card
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        child: const Icon(CupertinoIcons.person_fill, color: AppColors.primary, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('BÙI ĐỨC VƯƠNG', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                            const SizedBox(height: 2),
                            Text('090123456789 • KYC Cấp 2', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                          ],
                        ),
                      ),
                      const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Group 1: Tài khoản & Nguồn tiền
              _buildMenuSection(
                title: 'Tài khoản & Thẻ',
                items: [
                  {'icon': CupertinoIcons.person_crop_circle_badge_checkmark, 'title': 'Hồ sơ & Định danh (eKYC)', 'onTap': () {}},
                  {'icon': CupertinoIcons.creditcard, 'title': 'Phương thức thanh toán & Nguồn tiền', 'onTap': () => context.push('/cards')},
                  {'icon': CupertinoIcons.person_2, 'title': 'Danh bạ người thụ hưởng', 'onTap': () {}},
                ],
              ),

              const SizedBox(height: 16),

              // Group 2: Bảo mật & Cài đặt
              _buildMenuSection(
                title: 'Bảo mật & Ứng dụng',
                items: [
                  {'icon': CupertinoIcons.lock_shield, 'title': 'Cài đặt bảo mật & Smart OTP', 'onTap': () {}},
                  {'icon': CupertinoIcons.device_phone_portrait, 'title': 'Quản lý phiên & Thiết bị đăng nhập', 'onTap': () {}},
                  {'icon': CupertinoIcons.gift, 'title': 'Giới thiệu bạn bè nhận thưởng', 'onTap': () {}},
                  {'icon': CupertinoIcons.question_circle, 'title': 'Trung tâm trợ giúp & Chat CSKH', 'onTap': () {}},
                ],
              ),

              const SizedBox(height: 24),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () => context.go('/auth/login'),
                icon: const Icon(CupertinoIcons.square_arrow_right, color: Colors.white),
                label: const Text('Đăng xuất tài khoản'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardDark,
                  side: const BorderSide(color: Colors.redAccent, width: 1),
                  foregroundColor: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection({required String title, required List<Map<String, dynamic>> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: AppTypography.titleMedium(color: AppColors.textSecondaryDark)),
        ),
        GlassCard(
          quality: GlassQuality.minimal,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              final isLast = idx == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    onTap: item['onTap'] as VoidCallback,
                    leading: Icon(item['icon'] as IconData, color: AppColors.primary, size: 22),
                    title: Text(item['title'] as String, style: AppTypography.bodyMedium(color: AppColors.textPrimaryDark)),
                    trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
                  ),
                  if (!isLast) const Divider(height: 1, indent: 54, color: AppColors.cardBorderDark),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
