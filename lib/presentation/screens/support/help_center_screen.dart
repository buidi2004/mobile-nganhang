import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'q': 'Tôi muốn nâng hạn mức giao dịch chuyển tiền?',
      'a': 'Quý khách vui lòng thực hiện xác thực eKYC bằng CCCD gắn chip tại mục Hồ sơ cá nhân để nâng lên Cấp 2 (100tr/ngày) hoặc kích hoạt Smart OTP PKI để nâng lên Cấp 3 (500tr/ngày).',
    },
    {
      'q': 'Làm sao để lấy lại mã PIN giao dịch khi bị quên?',
      'a': 'Vào Cài đặt bảo mật -> Quên mã PIN -> Hệ thống sẽ gửi OTP xác minh danh tính tới SĐT chính chủ để cấp quyền đặt lại mã PIN 6 số.',
    },
    {
      'q': 'Giao dịch chuyển tiền thành công nhưng bên kia chưa nhận được?',
      'a': 'Giao dịch Napas 24/7 thường được xử lý tức thì trong 3-5 giây. Một số trường hợp nghẽn mạng liên ngân hàng có thể mất từ 15-30 phút. Quý khách có thể vào Chi tiết giao dịch -> Tải biên lai PDF hoặc chat với CSKH để tra soát.',
    },
    {
      'q': 'Phí chuyển tiền và thanh toán hóa đơn như thế nào?',
      'a': 'Hoàn toàn miễn phí 100% đối với chuyển tiền nội bộ, nạp rút tiền ví, và thanh toán tiền điện, nước, internet.',
    },
  ];

  void _createTicketModal(BuildContext context) {
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();

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
                Text('Gửi Yêu Cầu Khiếu Nại / Hỗ Trợ', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(CupertinoIcons.xmark, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Tiêu đề vấn đề (ví dụ: Tra soát giao dịch)',
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentCtrl,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mô tả chi tiết sự cố cần hỗ trợ...',
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.emeraldGreen,
                    content: Text('Yêu cầu hỗ trợ đã được tạo! Mã Ticket: #TK2026-9921'),
                  ),
                );
              },
              child: const Text('Gửi yêu cầu hỗ trợ'),
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
        title: const Text('Trung Tâm Trợ Giúp'),
        backgroundColor: Colors.transparent,
      ),
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
                    Text(
                      'Đội ngũ chăm sóc khách hàng Sen Hồng luôn sẵn sàng giải đáp mọi thắc mắc và khiếu nại',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmall(color: AppColors.textSecondaryDark),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.push('/support/live-chat'),
                            icon: const Icon(CupertinoIcons.bubble_left_bubble_right_fill, size: 18),
                            label: const Text('Live Chat 24/7'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: AppColors.primary),
                              foregroundColor: AppColors.primaryLight,
                            ),
                            onPressed: () => _createTicketModal(context),
                            icon: const Icon(CupertinoIcons.ticket_fill, size: 18),
                            label: const Text('Gửi Ticket'),
                          ),
                        ),
                      ],
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
