import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedFilter = 0; // 0: Tất cả, 1: Chuyển, 2: Nạp/Rút, 3: Hóa đơn

  final List<String> _filters = ['Tất cả', 'Chuyển tiền', 'Nạp / Rút', 'Hóa đơn'];

  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': 'TX1',
      'title': 'Chuyển tiền tới NGUYEN VAN A',
      'desc': 'Chuyen tien an trua',
      'amount': -150000.0,
      'date': 'Hôm nay, 10:30',
      'type': 'transfer',
      'status': 'Thành công',
    },
    {
      'id': 'TX2',
      'title': 'Nạp tiền từ VCB *8899',
      'desc': 'Nap tien vao vi Sen Hong',
      'amount': 2000000.0,
      'date': 'Hôm qua, 18:20',
      'type': 'deposit',
      'status': 'Thành công',
    },
    {
      'id': 'TX3',
      'title': 'Thanh toán EVN Hà Nội',
      'desc': 'Tien dien thang 08/2026',
      'amount': -485000.0,
      'date': '02/09/2026, 09:15',
      'type': 'bill',
      'status': 'Thành công',
    },
    {
      'id': 'TX4',
      'title': 'Nạp tiền điện thoại Viettel',
      'desc': 'Topup 0987654321',
      'amount': -100000.0,
      'date': '01/09/2026, 14:00',
      'type': 'bill',
      'status': 'Thành công',
    },
    {
      'id': 'TX5',
      'title': 'Rút tiền về Techcombank *6688',
      'desc': 'Rut tien tieu dung',
      'amount': -1000000.0,
      'date': '28/08/2026, 16:45',
      'type': 'withdraw',
      'status': 'Thành công',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Lịch Sử Giao Dịch'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đang xuất file sao kê Excel/PDF...')),
              );
            },
            icon: const Icon(Iconsax.document_download, color: AppColors.primary),
            tooltip: 'Xuất sao kê',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: List.generate(_filters.length, (idx) {
                  final isSelected = _selectedFilter == idx;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_filters[idx]),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimaryLight,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? AppColors.bottomBarCyan : Colors.white.withOpacity(0.6),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                      shadowColor: AppColors.bottomBarGlow.withOpacity(0.4),
                      elevation: isSelected ? 3 : 0,
                      onSelected: (_) => setState(() => _selectedFilter = idx),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 8),

            // Transactions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _allTransactions.length,
                itemBuilder: (context, index) {
                  final tx = _allTransactions[index];
                  final isPositive = (tx['amount'] as double) > 0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GlassCard(
                      quality: GlassQuality.minimal, // Minimal: tối ưu 0 chi phí shader khi cuộn mượt mà
                      child: Material(type: MaterialType.transparency, child: ListTile(
                        onTap: () {
                          context.push(
                            '/history/detail?id=${tx['id']}&title=${tx['title']}&amount=${tx['amount']}&time=${tx['date']}&note=${tx['desc']}',
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        leading: CircleAvatar(
                          backgroundColor: isPositive
                              ? AppColors.emeraldGreen.withOpacity(0.15)
                              : AppColors.primary.withOpacity(0.15),
                          child: Icon(
                            isPositive ? Iconsax.money_recive : Iconsax.money_send,
                            color: isPositive ? AppColors.emeraldGreen : AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          tx['title'],
                          style: AppTypography.titleMedium(color: AppColors.textPrimaryLight),
                        ),
                        subtitle: Text(
                          '${tx['desc']}\n${tx['date']}',
                          style: AppTypography.bodySmall(color: AppColors.textSecondaryLight),
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${isPositive ? '+' : ''}${CurrencyFormatter.formatVND(tx['amount'])}',
                              style: AppTypography.titleMedium(
                                color: isPositive ? AppColors.emeraldGreen : AppColors.textPrimaryLight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tx['status'],
                              style: const TextStyle(fontSize: 11, color: AppColors.emeraldGreen),
                            ),
                          ],
                        ),
                      )),
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
}
