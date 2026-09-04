import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class BillPaymentScreen extends StatelessWidget {
  const BillPaymentScreen({super.key});

  final List<Map<String, dynamic>> _billCategories = const [
    {'icon': CupertinoIcons.bolt_fill, 'label': 'Tiền điện', 'color': AppColors.accentGold, 'ncc': 'EVN Toàn quốc'},
    {'icon': CupertinoIcons.drop_fill, 'label': 'Tiền nước', 'color': Colors.blueAccent, 'ncc': 'Sawaco / Viwaco'},
    {'icon': CupertinoIcons.wifi, 'label': 'Internet', 'color': AppColors.emeraldGreen, 'ncc': 'VNPT / FPT / Viettel'},
    {'icon': CupertinoIcons.device_phone_portrait, 'label': 'Nạp ĐT', 'color': AppColors.primary, 'ncc': 'Trả trước & Trả sau'},
    {'icon': CupertinoIcons.tv_fill, 'label': 'Truyền hình', 'color': AppColors.softPurple, 'ncc': 'K+ / VTVCab / FPT Play'},
    {'icon': CupertinoIcons.book_fill, 'label': 'Học phí', 'color': Colors.orangeAccent, 'ncc': 'Trường học / Đào tạo'},
    {'icon': CupertinoIcons.building_2_fill, 'label': 'Phí chung cư', 'color': Colors.teal, 'ncc': 'BQL Tòa nhà'},
    {'icon': CupertinoIcons.shield_fill, 'label': 'Bảo hiểm', 'color': Colors.pinkAccent, 'ncc': 'Bảo Việt / Prudential'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Thanh Toán Hóa Đơn')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chọn loại dịch vụ', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 6),
              Text('Thanh toán tự động, chiết khấu lên đến 5%', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 20),

              // Categories Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: mechanicalGridDelegate,
                itemCount: _billCategories.length,
                itemBuilder: (context, index) {
                  final cat = _billCategories[index];
                  return GlassCard(
                    quality: GlassQuality.minimal,
                    child: InkWell(
                      onTap: () {
                        if (cat['label'] == 'Nạp ĐT') {
                          context.push('/bills/phone-recharge');
                        } else {
                          context.push('/bills/input?service=${cat['label']}');
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (cat['color'] as Color).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(cat['label'] as String, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                            const SizedBox(height: 2),
                            Text(cat['ncc'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppColors.textMutedDark)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const mechanicalGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 14,
    crossAxisSpacing: 14,
    childAspectRatio: 1.25,
  );
}
