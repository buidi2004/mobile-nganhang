import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  void _onUseVoucher(BuildContext context, Map<String, dynamic> v) {
    final tag = v['tag'] as String;
    if (tag == 'Nạp ĐT') {
      context.push('/bills/phone-recharge');
    } else if (tag == 'Hóa đơn') {
      context.push('/bills/input?service=Tiền điện');
    } else {
      context.push('/transfer');
    }
  }

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
                child: InkWell(
                  onTap: () => _onUseVoucher(context, v),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: (v['color'] as Color).withOpacity(0.18),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: (v['color'] as Color).withOpacity(0.35),
                                ),
                              ),
                              child: Icon(CupertinoIcons.ticket_fill, color: v['color'] as Color, size: 28),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(v['discount'] as String, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: AppColors.bottomBarCyan.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: AppColors.bottomBarCyan.withOpacity(0.4)),
                                        ),
                                        child: Text(
                                          v['tag'] as String,
                                          style: const TextStyle(
                                            color: AppColors.bottomBarCyan,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(v['desc'] as String, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: AppColors.cardBorderDark),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(v['expiry'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textMutedDark)),
                            InkWell(
                              onTap: () => _onUseVoucher(context, v),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.bottomBarGlow.withOpacity(0.30),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Dùng ngay', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 4),
                                    Icon(CupertinoIcons.arrow_right, size: 12, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
