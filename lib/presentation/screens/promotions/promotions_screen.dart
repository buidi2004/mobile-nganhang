import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  final List<Map<String, dynamic>> _vouchers = const [
    {
      'code': 'SENHONG50',
      'discount': 'Giảm 50.000đ',
      'desc': 'Áp dụng cho hóa đơn điện thoại từ 100k',
      'expiry': 'HSD: 30/09/2026',
      'tag': 'Nạp ĐT',
      'color': AppColors.emeraldGreen,
    },
    {
      'code': 'EVN100K',
      'discount': 'Hoàn 100.000đ',
      'desc': 'Thanh toán tiền điện EVN toàn quốc',
      'expiry': 'HSD: 15/09/2026',
      'tag': 'Hóa đơn',
      'color': AppColors.accentGold,
    },
    {
      'code': 'FREESHIP',
      'discount': 'Miễn phí 100%',
      'desc': 'Miễn phí mọi giao dịch chuyển tiền ngoài hệ thống',
      'expiry': 'HSD: Vô thời hạn',
      'tag': 'Chuyển tiền',
      'color': AppColors.primary,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Ưu Đãi & Quà Tặng'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
          itemCount: _vouchers.length,
          itemBuilder: (context, index) {
            final v = _vouchers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (v['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(CupertinoIcons.ticket_fill, color: v['color'], size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(v['discount'], style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(v['tag'], style: const TextStyle(color: AppColors.primaryLight, fontSize: 11)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(v['desc'], style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                            const SizedBox(height: 6),
                            Text(v['expiry'], style: AppTypography.bodySmall(color: AppColors.textMutedDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
