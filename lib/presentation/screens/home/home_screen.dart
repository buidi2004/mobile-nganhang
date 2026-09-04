import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';
import 'package:sen_hong_bank/presentation/widgets/balance_card.dart';
import 'package:sen_hong_bank/presentation/widgets/curved_promo_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hideBalance = false;
  final double _balance = 12580000;

  final List<Map<String, dynamic>> _quickServices = [
    {'icon': CupertinoIcons.paperplane_fill, 'label': 'Chuyển tiền', 'color': AppColors.primary, 'route': '/transfer'},
    {'icon': CupertinoIcons.device_phone_portrait, 'label': 'Nạp ĐT', 'color': AppColors.emeraldGreen, 'route': '/bills'},
    {'icon': CupertinoIcons.bolt_fill, 'label': 'Điện nước', 'color': AppColors.accentGold, 'route': '/bills'},
    {'icon': CupertinoIcons.money_dollar_circle_fill, 'label': 'Tiết kiệm', 'color': AppColors.vividTeal, 'route': '/bills'},
    {'icon': CupertinoIcons.chart_bar_alt_fill, 'label': 'Vay nhanh', 'color': AppColors.softPurple, 'route': '/bills'},
    {'icon': CupertinoIcons.ticket_fill, 'label': 'Vietlott', 'color': Colors.redAccent, 'route': '/bills'},
    {'icon': CupertinoIcons.creditcard_fill, 'label': 'Quản lý thẻ', 'color': Colors.blueAccent, 'route': '/cards'},
    {'icon': CupertinoIcons.ellipsis, 'label': 'Xem thêm', 'color': Colors.grey, 'route': '/more'},
  ];

  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'title': 'Chuyển tiền tới NGUYEN VAN A',
      'desc': 'Chuyen tien an trua',
      'amount': -150000.0,
      'time': '10:30 Hôm nay',
      'type': 'transfer',
    },
    {
      'title': 'Nạp tiền từ VCB *8899',
      'desc': 'Nap tien vao vi Sen Hong',
      'amount': 2000000.0,
      'time': 'Hôm qua',
      'type': 'deposit',
    },
    {
      'title': 'Thanh toán EVN Hà Nội',
      'desc': 'Tien dien thang 08/2026',
      'amount': -485000.0,
      'time': '02/09/2026',
      'type': 'bill',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sliver Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primary.withOpacity(0.12),
                          child: const Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào,',
                              style: AppTypography.bodySmall(color: AppColors.textSecondaryLight),
                            ),
                            Text(
                              'BÙI ĐỨC VƯƠNG',
                              style: AppTypography.titleMedium(color: AppColors.textPrimaryLight),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.push('/history'),
                          icon: const Icon(CupertinoIcons.search, color: AppColors.textPrimaryLight),
                        ),
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.bell_fill, color: AppColors.textPrimaryLight),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Balance Card Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: BalanceCard(
                  balance: _balance,
                  isHidden: _hideBalance,
                  onToggleVisibility: () => setState(() => _hideBalance = !_hideBalance),
                  onDeposit: () => context.push('/transfer'),
                  onWithdraw: () => context.push('/transfer'),
                  onTransfer: () => context.push('/transfer'),
                  onQr: () => context.push('/my-qr'),
                ),
              ),
            ),

            // Quick Services Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  'Dịch vụ nổi bật',
                  style: AppTypography.titleLarge(color: AppColors.textPrimaryLight),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _quickServices[index];
                    return InkWell(
                      onTap: () => context.push(item['route']),
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: (item['color'] as Color).withOpacity(0.2),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(item['icon'], color: item['color'], size: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['label'],
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall(color: AppColors.textPrimaryLight),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: _quickServices.length,
                ),
              ),
            ),

            // Banner Promotion (Curved shape bẻ cong ảnh dưới)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: CurvedPromoBanner(
                  onRegisterTap: () => context.push('/bills'),
                ),
              ),
            ),

            // Recent Transactions Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giao dịch gần đây',
                      style: AppTypography.titleLarge(color: AppColors.textPrimaryLight),
                    ),
                    TextButton(
                      onPressed: () => context.push('/history'),
                      child: const Text('Xem tất cả', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Transactions List
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final tx = _recentTransactions[index];
                    final isPositive = (tx['amount'] as double) > 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.cardBorderLight, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: CircleAvatar(
                            backgroundColor: isPositive
                                ? AppColors.emeraldGreen.withOpacity(0.12)
                                : AppColors.primary.withOpacity(0.12),
                            child: Icon(
                              isPositive ? CupertinoIcons.arrow_down_left : CupertinoIcons.arrow_up_right,
                              color: isPositive ? AppColors.emeraldGreen : AppColors.primary,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            tx['title'],
                            style: AppTypography.titleMedium(color: AppColors.textPrimaryLight),
                          ),
                          subtitle: Text(
                            '${tx['desc']} • ${tx['time']}',
                            style: AppTypography.bodySmall(color: AppColors.textSecondaryLight),
                          ),
                          trailing: Text(
                            '${isPositive ? '+' : ''}${CurrencyFormatter.formatVND(tx['amount'])}',
                            style: AppTypography.titleMedium(
                              color: isPositive ? AppColors.emeraldGreen : AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _recentTransactions.length,
                ),
              ),
            ),

            // Bottom Curved Promo & Feature Banner ("bẻ cong ảnh dưới" & "ghép ảnh chéo")
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: CurvedPromoBanner(
                  isDiagonalSlanted: true,
                  onRegisterTap: () => context.push('/promotions'),
                ),
              ),
            ),

            // Khoảng trống đệm để cuộn banner lướt qua dưới thanh kính nổi (Glass Refraction)
            const SliverToBoxAdapter(
              child: SizedBox(height: 85),
            ),
          ],
        ),
      ),
    );
  }
}
