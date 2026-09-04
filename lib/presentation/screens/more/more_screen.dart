import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal_1, color: Colors.white),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
          child: Column(
            children: [
              // User Card
              GlassCard(
                quality: GlassQuality.minimal,
                child: InkWell(
                  onTap: () => context.push('/profile'),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.bottomBarGlow.withOpacity(0.35),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0xFF0F172A),
                            child: Icon(Iconsax.profile_circle_copy, color: AppColors.primaryLight, size: 28),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BÙI ĐỨC VƯƠNG', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                              const SizedBox(height: 2),
                              Text('090123456789 • eKYC Cấp 2', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                            ],
                          ),
                        ),
                        const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 18),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Group 1: Tài khoản & Nguồn tiền
              _buildMenuSection(
                title: 'Tài khoản & Thẻ',
                items: [
                  {'icon': Iconsax.user_tick, 'title': 'Hồ sơ & Định danh (eKYC)', 'onTap': () => context.push('/profile/ekyc')},
                  {'icon': Iconsax.cards, 'title': 'Phương thức thanh toán & Nguồn tiền', 'onTap': () => context.push('/payment-methods')},
                  {'icon': Iconsax.bank, 'title': 'Tài khoản ngân hàng liên kết', 'onTap': () => context.push('/bank-cards')},
                  {'icon': Iconsax.profile_2user, 'title': 'Danh bạ người thụ hưởng', 'onTap': () => context.push('/beneficiaries')},
                ],
              ),

              const SizedBox(height: 16),

              // Group 2: Bảo mật & Cài đặt
              _buildMenuSection(
                title: 'Bảo mật & Ứng dụng',
                items: [
                  {'icon': Iconsax.security_safe, 'title': 'Cài đặt bảo mật & Smart OTP', 'onTap': () => context.push('/settings/security')},
                  {'icon': Iconsax.devices_1, 'title': 'Quản lý phiên & Thiết bị đăng nhập', 'onTap': () => context.push('/settings/devices')},
                  {'icon': Iconsax.setting_2, 'title': 'Cài đặt giao diện & Hình nền app', 'onTap': () => context.push('/settings')},
                  {'icon': Iconsax.gift, 'title': 'Giới thiệu bạn bè nhận thưởng', 'onTap': () => context.push('/referral')},
                  {'icon': Iconsax.call_calling, 'title': 'Trung tâm trợ giúp & Live Chat CSKH', 'onTap': () => context.push('/support/help-center')},
                  {'icon': Iconsax.document_text, 'title': 'Điều khoản dịch vụ & Pháp lý', 'onTap': () => context.push('/auth/terms')},
                ],
              ),

              const SizedBox(height: 24),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () => context.go('/auth/login'),
                icon: const Icon(Iconsax.logout_1, color: Colors.white),
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
                  Material(type: MaterialType.transparency, child: ListTile(
                    onTap: item['onTap'] as VoidCallback,
                    leading: Icon(item['icon'] as IconData, color: AppColors.primary, size: 22),
                    title: Text(item['title'] as String, style: AppTypography.bodyMedium(color: AppColors.textPrimaryDark)),
                    trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                  )),
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
