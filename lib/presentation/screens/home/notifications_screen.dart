import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedTab = 0; // 0: Biến động số dư, 1: Khuyến mãi, 2: Hệ thống

  final List<Map<String, dynamic>> _balanceNotifs = [
    {
      'id': 'n1',
      'title': 'Biến động số dư: +2.000.000 VND',
      'body': 'Bạn vừa nạp thành công 2.000.000 VND từ VCB *8899 vào ví Sen Hồng.',
      'time': '10:30 Hôm nay',
      'isRead': false,
      'txId': 'TX9921882',
      'amount': 2000000.0,
    },
    {
      'id': 'n2',
      'title': 'Biến động số dư: -150.000 VND',
      'body': 'Chuyển tiền thành công tới NGUYEN VAN A. Nội dung: Chuyen tien an trua',
      'time': '09:15 Hôm nay',
      'isRead': false,
      'txId': 'TX9921800',
      'amount': -150000.0,
    },
    {
      'id': 'n3',
      'title': 'Biến động số dư: -485.000 VND',
      'body': 'Thanh toán tiền điện EVN Hà Nội (PE0100023456) thành công.',
      'time': 'Hôm qua',
      'isRead': true,
      'txId': 'TX9921750',
      'amount': -485000.0,
    },
  ];

  final List<Map<String, dynamic>> _promoNotifs = [
    {
      'id': 'p1',
      'title': 'Tặng Voucher 50.000đ Nạp ĐT',
      'body': 'Mã NAPTEN50 đã được thêm vào ví ưu đãi của bạn. HSD: 15/09/2026.',
      'time': '02/09/2026',
      'isRead': false,
    },
    {
      'id': 'p2',
      'title': 'Hoàn tiền 5% hóa đơn Điện Nước',
      'body': 'Thanh toán tiền điện, nước tháng 09 để nhận hoàn tiền tới 50.000đ.',
      'time': '01/09/2026',
      'isRead': true,
    },
  ];

  final List<Map<String, dynamic>> _systemNotifs = [
    {
      'id': 's1',
      'title': 'Nâng cấp bảo mật sinh trắc học',
      'body': 'Sen Hồng đã cập nhật công nghệ AI Liveness chống giả mạo khuôn mặt.',
      'time': '01/09/2026',
      'isRead': true,
    },
    {
      'id': 's2',
      'title': 'Thông báo bảo trì hệ thống Napas',
      'body': 'Hệ thống chuyển tiền nhanh Napas 24/7 hoạt động ổn định.',
      'time': '28/08/2026',
      'isRead': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _balanceNotifs) {
        n['isRead'] = true;
      }
      for (var n in _promoNotifs) {
        n['isRead'] = true;
      }
      for (var n in _systemNotifs) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã đánh dấu đọc tất cả thông báo')),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentList;
    if (_selectedTab == 0) {
      currentList = _balanceNotifs;
    } else if (_selectedTab == 1) {
      currentList = _promoNotifs;
    } else {
      currentList = _systemNotifs;
    }

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Thông Báo'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Đọc tất cả',
            icon: const Icon(CupertinoIcons.checkmark_circle),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 3 Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  _buildTab(0, 'Biến động số dư'),
                  const SizedBox(width: 8),
                  _buildTab(1, 'Khuyến mãi'),
                  const SizedBox(width: 8),
                  _buildTab(2, 'Hệ thống'),
                ],
              ),
            ),
            Expanded(
              child: currentList.isEmpty
                  ? Center(
                      child: Text('Không có thông báo nào', style: AppTypography.bodyMedium(color: AppColors.textMutedDark)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: currentList.length,
                      itemBuilder: (context, idx) {
                        final item = currentList[idx];
                        final isRead = item['isRead'] as bool;
                        final isBalance = _selectedTab == 0;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassCard(
                            quality: GlassQuality.minimal,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              onTap: () {
                                setState(() => item['isRead'] = true);
                                if (isBalance) {
                                  context.push(
                                    '/history/detail?id=${item['txId']}&title=${item['title']}&amount=${item['amount']}&time=${item['time']}&note=${item['body']}',
                                  );
                                } else if (_selectedTab == 1) {
                                  context.push('/promotions');
                                } else {
                                  context.push('/settings/security');
                                }
                              },
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: isBalance
                                        ? AppColors.primary.withOpacity(0.18)
                                        : (_selectedTab == 1 ? AppColors.accentGold.withOpacity(0.18) : AppColors.vividTeal.withOpacity(0.18)),
                                    child: Icon(
                                      isBalance
                                          ? CupertinoIcons.money_dollar_circle_fill
                                          : (_selectedTab == 1 ? CupertinoIcons.gift_fill : CupertinoIcons.bell_fill),
                                      color: isBalance
                                          ? AppColors.primary
                                          : (_selectedTab == 1 ? AppColors.accentGold : AppColors.vividTeal),
                                      size: 20,
                                    ),
                                  ),
                                  if (!isRead)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              title: Text(
                                item['title'] as String,
                                style: AppTypography.titleMedium(
                                  color: isRead ? AppColors.textSecondaryDark : AppColors.textPrimaryDark,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    item['body'] as String,
                                    style: AppTypography.bodySmall(color: isRead ? AppColors.textMutedDark : AppColors.textSecondaryDark),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(item['time'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark)),
                                ],
                              ),
                              trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 14),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: ChoiceChip(
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        selected: isSelected,
        onSelected: (val) => setState(() => _selectedTab = index),
        selectedColor: AppColors.primary,
        side: BorderSide(
          color: isSelected ? AppColors.bottomBarCyan : Colors.transparent,
          width: 1.2,
        ),
        shadowColor: AppColors.bottomBarGlow.withOpacity(0.4),
        elevation: isSelected ? 3 : 0,
      ),
    );
  }
}
