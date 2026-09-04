import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Cài Đặt Bảo Mật')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
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
                  ListTile(
                    title: Text('Đổi mật khẩu đăng nhập', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  ListTile(
                    title: Text('Đổi mã PIN giao dịch 6 số', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
