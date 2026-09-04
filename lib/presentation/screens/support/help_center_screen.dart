import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'q': 'Tôi muốn nâng hạn mức giao dịch chuyển tiền?',
      'a': 'Quý khách vui lòng thực hiện xác thực eKYC bằng CCCD gắn chip tại mục Hồ sơ cá nhân.',
    },
    {
      'q': 'Làm sao để lấy lại mã PIN giao dịch khi bị quên?',
      'a': 'Vào Cài đặt bảo mật -> Quên mã PIN -> Hệ thống sẽ gửi OTP xác minh danh tính để đặt lại PIN.',
    },
    {
      'q': 'Giao dịch chuyển tiền thành công nhưng bên kia chưa nhận được?',
      'a': 'Giao dịch Napas 24/7 thường được xử lý tức thì. Nếu quá 15 phút, vui lòng bấm Tải biên lai và gửi Ticket CSKH.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Trung Tâm Trợ Giúp')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Quick Support Box
            GlassCard(
              quality: GlassQuality.minimal,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(CupertinoIcons.chat_bubble_2_fill, color: AppColors.primary, size: 40),
                    const SizedBox(height: 10),
                    Text('Hỗ trợ trực tuyến 24/7', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                    const SizedBox(height: 4),
                    Text('Đội ngũ CSKH Sen Hồng luôn sẵn sàng hỗ trợ bạn', textAlign: TextAlign.center, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.bubble_left_bubble_right_fill, size: 18),
                      label: const Text('Chat với hỗ trợ viên'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Câu hỏi thường gặp (FAQ)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 12),
            ..._faqs.map((f) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: ExpansionTile(
                    title: Text(f['q']!, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(f['a']!, style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
