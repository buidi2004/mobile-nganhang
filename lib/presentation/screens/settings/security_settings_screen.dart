import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricLogin = true;
  bool _twoFactorAuth = true;
  bool _pinLockApp = false;

  void _showChangePasswordModal() {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Đổi Mật Khẩu Đăng Nhập', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Iconsax.close_circle, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: oldPassCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mật khẩu hiện tại',
                prefixIcon: const Icon(Iconsax.lock_1, color: AppColors.primary),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPassCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mật khẩu mới (tối thiểu 6 ký tự)',
                prefixIcon: const Icon(Iconsax.lock_copy, color: AppColors.primary),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPassCtrl,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu mới',
                prefixIcon: const Icon(Iconsax.shield_tick_copy, color: AppColors.primary),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (newPassCtrl.text != confirmPassCtrl.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mật khẩu mới xác nhận không khớp')),
                  );
                  return;
                }
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.emeraldGreen,
                    content: Text('Đổi mật khẩu thành công!'),
                  ),
                );
              },
              child: const Text('Lưu mật khẩu mới'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cài Đặt Bảo Mật'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Phương thức xác thực sinh trắc', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),
            GlassCard(
              quality: GlassQuality.minimal,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: _biometricLogin,
                    activeTrackColor: AppColors.primary,
                    title: Text('Đăng nhập bằng FaceID / Vân tay', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Sử dụng cảm biến sinh trắc học trên máy', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _biometricLogin = v),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  SwitchListTile.adaptive(
                    value: _twoFactorAuth,
                    activeTrackColor: AppColors.primary,
                    title: Text('Xác thực 2 lớp (2FA)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Bắt buộc OTP khi giao dịch trên 5.000.000đ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _twoFactorAuth = v),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  SwitchListTile.adaptive(
                    value: _pinLockApp,
                    activeTrackColor: AppColors.primary,
                    title: Text('Khóa màn hình khi rời ứng dụng', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Yêu cầu PIN hoặc FaceID mỗi khi mở lại app', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _pinLockApp = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('Mật khẩu & Mã PIN', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Đổi mật khẩu đăng nhập', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Cập nhật định kỳ để bảo vệ tài khoản', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    onTap: _showChangePasswordModal,
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  ListTile(
                    title: Text('Đổi mã PIN giao dịch 6 số', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('PIN ký các lệnh chuyển tiền & rút tiền', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    onTap: () => context.push('/auth/set-pin'),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  ListTile(
                    title: Text('Quên mã PIN giao dịch?', style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                    subtitle: Text('Xác minh danh tính để đặt lại mã PIN', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    onTap: () => context.push('/auth/forgot-pin'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('Thiết bị & Phiên', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: ListTile(
                onTap: () => context.push('/settings/devices'),
                leading: const Icon(Iconsax.devices_1, color: AppColors.primary),
                title: Text('Quản lý phiên đăng nhập', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                subtitle: Text('Xem các thiết bị đang đăng nhập & đăng xuất từ xa', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
