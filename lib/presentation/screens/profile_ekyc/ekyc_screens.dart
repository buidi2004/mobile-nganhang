import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class EKycScreen extends StatelessWidget {
  const EKycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Định Danh Điện Tử (eKYC)')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('3 Bước định danh tài khoản', style: AppTypography.displaySmall(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              Text('Nâng hạn mức giao dịch lên 500.000.000đ/ngày', style: AppTypography.bodyMedium(color: AppColors.emeraldGreen)),
              const SizedBox(height: 32),
              _buildStepCard(1, 'Chụp mặt trước CCCD / Hộ chiếu', 'Đảm bảo rõ nét, không lóa sáng, không mất góc'),
              const SizedBox(height: 16),
              _buildStepCard(2, 'Chụp mặt sau CCCD gắn chip', 'Rõ dải mã vạch MRZ và dấu mộc giáp lai'),
              const SizedBox(height: 16),
              _buildStepCard(3, 'Quét khuôn mặt xác thực (Liveness)', 'Quay trái, quay phải, chớp mắt theo hướng dẫn'),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.camera_fill),
                label: const Text('Bắt đầu xác thực eKYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(int step, String title, String desc) {
    return GlassCard(
      quality: GlassQuality.minimal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: Text('$step', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                  const SizedBox(height: 2),
                  Text(desc, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
