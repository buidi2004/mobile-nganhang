import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  final String _myRefCode = 'SENHONG8866';

  final List<Map<String, dynamic>> _invitedFriends = const [
    {'name': 'Nguyễn Văn Minh', 'phone': '0988***123', 'date': '02/09/2026', 'reward': 50000.0, 'status': 'Đã nhận thưởng'},
    {'name': 'Trần Hoàng Long', 'phone': '0912***456', 'date': '29/08/2026', 'reward': 50000.0, 'status': 'Đã nhận thưởng'},
    {'name': 'Phạm Thuỳ Dương', 'phone': '0977***789', 'date': '20/08/2026', 'reward': 50000.0, 'status': 'Đã nhận thưởng'},
    {'name': 'Lê Đức Hải', 'phone': '0903***999', 'date': '15/08/2026', 'reward': 0.0, 'status': 'Chờ nạp tiền đầu'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Giới Thiệu Bạn Bè'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Promo Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF032B43), Color(0xFF0077B6), Color(0xFF00B4D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.bottomBarCyan.withOpacity(0.4), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bottomBarGlow.withOpacity(0.20),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(CupertinoIcons.gift_fill, color: AppColors.accentGold, size: 32),
                        const SizedBox(width: 10),
                        Text('RỦ BẠN CÙNG DÙNG SEN HỒNG', style: AppTypography.titleLarge(color: AppColors.accentGold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Nhận ngay 50.000 đ cho mỗi lượt bạn bè tải app và phát sinh giao dịch đầu tiên.',
                      style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Referral Code Box
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Mã giới thiệu của bạn', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.bottomBarCyan, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.bottomBarGlow.withOpacity(0.30),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Text(
                          _myRefCode,
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.emeraldGreen,
                              content: Text('Đã sao chép link giới thiệu: https://senhongbank.vn/ref/SENHONG8866'),
                            ),
                          );
                        },
                        icon: const Icon(CupertinoIcons.doc_on_clipboard_fill, size: 18),
                        label: const Text('Sao chép mã & Link mời'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      quality: GlassQuality.minimal,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Đã giới thiệu', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                            const SizedBox(height: 4),
                            Text('4 Bạn bè', style: AppTypography.titleLarge(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlassCard(
                      quality: GlassQuality.minimal,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tiền thưởng nhận', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                            const SizedBox(height: 4),
                            Text('150.000 đ', style: AppTypography.titleLarge(color: AppColors.emeraldGreen)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text('Lịch sử bạn bè tham gia', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 12),

              ..._invitedFriends.map((f) {
                final isDone = f['reward'] > 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassCard(
                    quality: GlassQuality.minimal,
                    child: Material(type: MaterialType.transparency, child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        child: const Icon(CupertinoIcons.person_fill, color: AppColors.primary, size: 18),
                      ),
                      title: Text(f['name'] as String, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text('${f['phone']} • ${f['date']}', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (isDone)
                            Text('+${CurrencyFormatter.formatVND(f['reward'] as double)}', style: const TextStyle(color: AppColors.emeraldGreen, fontWeight: FontWeight.bold))
                          else
                            const Text('Chờ nạp', style: TextStyle(color: AppColors.accentGold, fontSize: 12)),
                          Text(f['status'] as String, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 10)),
                        ],
                      ),
                    )),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
