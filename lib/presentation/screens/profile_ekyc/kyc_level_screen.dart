import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class KycLevelScreen extends StatelessWidget {
  const KycLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cấp Độ Định Danh & Hạn Mức'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Hạn mức giao dịch tài khoản', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 6),
            Text('Nâng cấp cấp độ định danh để mở rộng hạn mức chuyển tiền và sử dụng toàn bộ tiện ích', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 20),

            _buildTierCard(
              tier: 1,
              title: 'Cấp 1: Cơ Bản (Số điện thoại)',
              limit: '5.000.000 đ / ngày',
              desc: 'Tài khoản đăng ký bằng SĐT, chưa hoàn tất chụp CCCD.',
              isCurrent: false,
              isCompleted: true,
              features: ['Chuyển tiền nội bộ Sen Hồng', 'Nạp tiền tối đa 5tr/ngày', 'Không thể rút về ngân hàng'],
            ),
            const SizedBox(height: 16),

            _buildTierCard(
              tier: 2,
              title: 'Cấp 2: Chuẩn (Đã eKYC CCCD)',
              limit: '100.000.000 đ / ngày',
              desc: 'Đã xác thực CCCD gắn chip và sinh trắc học khuôn mặt.',
              isCurrent: true,
              isCompleted: true,
              features: ['Chuyển liên ngân hàng Napas 24/7', 'Rút tiền về tài khoản ngân hàng', 'Thanh toán hóa đơn tự động', 'Mở sổ tiết kiệm online'],
            ),
            const SizedBox(height: 16),

            _buildTierCard(
              tier: 3,
              title: 'Cấp 3: Nâng Cao (Smart OTP / PKI)',
              limit: '500.000.000 đ / ngày',
              desc: 'Ký chứng thư số điện tử PKI và xác thực tài khoản ngân hàng liên kết chính chủ.',
              isCurrent: false,
              isCompleted: false,
              features: ['Hạn mức chuyển tiền lên đến 500tr/ngày', 'Hạn mức tháng 2.000.000.000 đ', 'Vay tiêu dùng hạn mức 50tr', 'Hỗ trợ ưu tiên CSKH 24/7'],
              onUpgrade: () => context.push('/profile/digital-signature'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTierCard({
    required int tier,
    required String title,
    required String limit,
    required String desc,
    required bool isCurrent,
    required bool isCompleted,
    required List<String> features,
    VoidCallback? onUpgrade,
  }) {
    return GlassCard(
      quality: GlassQuality.minimal,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: isCurrent ? Border.all(color: AppColors.emeraldGreen, width: 2) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.titleMedium(color: isCurrent ? AppColors.emeraldGreen : AppColors.textPrimaryDark)),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Hiện tại', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(limit, style: AppTypography.displaySmall(color: isCurrent ? AppColors.primaryLight : Colors.white)),
            const SizedBox(height: 4),
            Text(desc, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
            const Divider(height: 24, color: AppColors.cardBorderDark),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        isCompleted ? CupertinoIcons.checkmark_alt_circle_fill : CupertinoIcons.circle,
                        size: 16,
                        color: isCompleted ? AppColors.emeraldGreen : AppColors.textMutedDark,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(f, style: const TextStyle(color: Colors.white70, fontSize: 13))),
                    ],
                  ),
                )),
            if (onUpgrade != null) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onUpgrade,
                child: const Text('Nâng cấp lên Cấp 3 ngay'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
