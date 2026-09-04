import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F172A),
      child: SafeArea(
        child: Column(
          children: [
            // Header User Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A2540), Color(0xFF0077B6), Color(0xFF00B4D8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.bottomBarCyan.withOpacity(0.4), width: 1.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(0.25),
                        child: const Icon(Iconsax.profile_circle_copy, color: Colors.white, size: 30),
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.close_circle, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'BÙI ĐỨC VƯƠNG',
                    style: AppTypography.titleLarge(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '0901234567 • STK: 108866889999',
                    style: AppTypography.bodySmall(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldGreen.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.emeraldGreen.withOpacity(0.5)),
                    ),
                    child: const Text(
                      'Đã Định Danh eKYC Cấp 2',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildItem(
                    context,
                    icon: Iconsax.user,
                    title: 'Hồ sơ cá nhân',
                    route: '/profile',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.security_safe,
                    title: 'Cài đặt bảo mật & Smart OTP',
                    route: '/settings/security',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.cards,
                    title: 'Quản lý thẻ & Nguồn tiền',
                    route: '/payment-methods',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.bank,
                    title: 'Tài khoản ngân hàng liên kết',
                    route: '/bank-cards',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.profile_2user,
                    title: 'Danh bạ người thụ hưởng',
                    route: '/beneficiaries',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.devices_1,
                    title: 'Quản lý thiết bị đăng nhập',
                    route: '/settings/devices',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.gift,
                    title: 'Giới thiệu bạn bè nhận thưởng',
                    route: '/referral',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.setting_2,
                    title: 'Giao diện & Cài đặt app',
                    route: '/settings',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.cpu_setting,
                    title: 'Cấu hình Server API',
                    route: '/settings/config',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.call_calling,
                    title: 'Trợ giúp & Live Chat CSKH',
                    route: '/support/help-center',
                  ),
                  _buildItem(
                    context,
                    icon: Iconsax.document_text,
                    title: 'Điều khoản dịch vụ & Pháp lý',
                    route: '/auth/terms',
                  ),
                ],
              ),
            ),

            // Footer Logout
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardDark,
                  side: const BorderSide(color: AppColors.error),
                  foregroundColor: AppColors.error,
                  minimumSize: const Size(double.infinity, 46),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/auth/login');
                },
                icon: const Icon(Iconsax.logout_1, size: 18),
                label: const Text('Đăng xuất tài khoản'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return Material(type: MaterialType.transparency, child: ListTile(
      leading: Icon(icon, color: AppColors.primaryLight, size: 20),
      title: Text(title, style: AppTypography.bodyMedium(color: Colors.white)),
      trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 14),
      onTap: () {
        Navigator.pop(context);
        context.push(route);
      },
    ));
  }
}
