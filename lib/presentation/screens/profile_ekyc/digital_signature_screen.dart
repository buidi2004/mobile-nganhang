import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class DigitalSignatureScreen extends StatefulWidget {
  const DigitalSignatureScreen({super.key});

  @override
  State<DigitalSignatureScreen> createState() => _DigitalSignatureScreenState();
}

class _DigitalSignatureScreenState extends State<DigitalSignatureScreen> {
  bool _smartOtpEnabled = true;
  final String _currentOtpCode = '882 190';
  final int _secondsRemaining = 24;

  void _syncOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Đã đồng bộ hóa thời gian Smart OTP thành công!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Chữ Ký Số & Smart OTP'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Smart OTP Token Card
            GlassCard(
              quality: GlassQuality.minimal,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(CupertinoIcons.shield_lefthalf_fill, color: AppColors.primary, size: 24),
                            SizedBox(width: 8),
                            Text('SMART OTP SEN HỒNG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('HOẠT ĐỘNG', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Mã xác thực giao dịch hiện tại', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    const SizedBox(height: 6),
                    Text(
                      _currentOtpCode,
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: AppColors.bottomBarGlow,
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.stopwatch, color: AppColors.accentGold, size: 14),
                        const SizedBox(width: 6),
                        Text('Tự động đổi sau ${_secondsRemaining}s', style: const TextStyle(color: AppColors.accentGold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _syncOtp,
                      icon: const Icon(CupertinoIcons.arrow_2_circlepath, size: 16, color: Colors.white),
                      label: const Text('Đồng bộ thời gian OTP', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text('Chứng thư số PKI cá nhân', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPkiRow('Chủ chứng thư', 'BÙI ĐỨC VƯƠNG (001204018899)'),
                    const SizedBox(height: 10),
                    _buildPkiRow('Nhà cung cấp chứng thực', 'VNPT-CA Cloud Identity'),
                    const SizedBox(height: 10),
                    _buildPkiRow('Tiêu chuẩn mã hóa', 'RSA 2048-bit / SHA-256'),
                    const SizedBox(height: 10),
                    _buildPkiRow('Thời hạn hiệu lực', '20/09/2024 - 20/09/2027'),
                    const SizedBox(height: 10),
                    _buildPkiRow('Trạng thái', 'Hợp lệ & Sẵn sàng ký duyệt', isGreen: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            GlassCard(
              quality: GlassQuality.minimal,
              child: SwitchListTile.adaptive(
                value: _smartOtpEnabled,
                activeTrackColor: AppColors.primary,
                title: Text('Kích hoạt Smart OTP trên máy này', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                subtitle: Text('Tự động điền mã OTP khi xác nhận giao dịch trên 10.000.000đ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                onChanged: (v) => setState(() => _smartOtpEnabled = v),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPkiRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            color: isGreen ? AppColors.emeraldGreen : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
