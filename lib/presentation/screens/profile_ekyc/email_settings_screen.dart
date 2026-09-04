import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class EmailSettingsScreen extends StatefulWidget {
  const EmailSettingsScreen({super.key});

  @override
  State<EmailSettingsScreen> createState() => _EmailSettingsScreenState();
}

class _EmailSettingsScreenState extends State<EmailSettingsScreen> {
  final TextEditingController _emailCtrl = TextEditingController(text: 'buiducvuong@example.com');
  bool _receiveVat = true;
  bool _receiveMonthlyStatement = true;
  bool _receiveSecurityAlerts = true;

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Đã cập nhật cài đặt email nhận hóa đơn VAT thành công!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cài Đặt Email & Hóa Đơn VAT'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Địa chỉ email nhận thông báo', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.mail_solid, color: AppColors.primary),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Đã xác thực', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            Text('Tùy chọn nhận tài liệu điện tử', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 12),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: _receiveVat,
                    activeTrackColor: AppColors.primary,
                    title: Text('Hóa đơn điện tử VAT', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Tự động gửi hóa đơn GTGT sau mỗi lần thanh toán phí hoặc dịch vụ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _receiveVat = v),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  SwitchListTile.adaptive(
                    value: _receiveMonthlyStatement,
                    activeTrackColor: AppColors.primary,
                    title: Text('Sao kê tài khoản hàng tháng', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Gửi file PDF sao kê thu chi vào ngày 01 hàng tháng', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _receiveMonthlyStatement = v),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.cardBorderDark),
                  SwitchListTile.adaptive(
                    value: _receiveSecurityAlerts,
                    activeTrackColor: AppColors.primary,
                    title: Text('Cảnh báo bảo mật & Đăng nhập mới', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('Thông báo ngay khi phát hiện phiên đăng nhập từ thiết bị lạ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    onChanged: (v) => setState(() => _receiveSecurityAlerts = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Lưu cài đặt email'),
            ),
          ],
        ),
      ),
    );
  }
}
