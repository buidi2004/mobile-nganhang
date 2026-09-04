import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final double _availableBalance = 12580000;
  final TextEditingController _amountCtrl = TextEditingController(text: '1000000');
  int _selectedBankIdx = 0;

  final List<Map<String, String>> _linkedBanks = const [
    {'bank': 'Vietcombank', 'acc': '0071001234567', 'name': 'BUI DUC VUONG', 'logo': 'VCB'},
    {'bank': 'Techcombank', 'acc': '1903344556677', 'name': 'BUI DUC VUONG', 'logo': 'TCB'},
    {'bank': 'BIDV', 'acc': '2151000987654', 'name': 'BUI DUC VUONG', 'logo': 'BIDV'},
  ];

  final List<double> _quickChips = [200000, 500000, 1000000, 2000000, 5000000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Rút Tiền Về Ngân Hàng'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorderDark),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Số dư khả dụng của ví', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        const SizedBox(height: 4),
                        Text(
                          CurrencyFormatter.formatVND(_availableBalance),
                          style: AppTypography.titleLarge(color: AppColors.emeraldGreen),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => setState(() => _amountCtrl.text = _availableBalance.toInt().toString()),
                      child: const Text('Rút tất cả', style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text('Nhập số tiền rút', style: AppTypography.titleMedium(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                style: AppTypography.displaySmall(color: AppColors.primaryLight),
                decoration: const InputDecoration(
                  suffixText: ' đ',
                  suffixStyle: TextStyle(color: AppColors.primaryLight, fontSize: 24),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _quickChips.map((amt) {
                  return ActionChip(
                    label: Text(CurrencyFormatter.formatVND(amt)),
                    backgroundColor: AppColors.cardDark,
                    labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
                    onPressed: () => setState(() => _amountCtrl.text = amt.toInt().toString()),
                  );
                }).toList(),
              ),

              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tài khoản nhận tiền', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                  TextButton.icon(
                    onPressed: () => context.push('/bank-cards'),
                    icon: const Icon(CupertinoIcons.plus, size: 16),
                    label: const Text('Thêm ngân hàng'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              ...List.generate(_linkedBanks.length, (idx) {
                final b = _linkedBanks[idx];
                final isSelected = _selectedBankIdx == idx;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected ? Border.all(color: AppColors.bottomBarCyan, width: 1.5) : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.bottomBarGlow.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: GlassCard(
                      quality: GlassQuality.minimal,
                      child: ListTile(
                        onTap: () => setState(() => _selectedBankIdx = idx),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.bottomBarCyan.withOpacity(0.2),
                          child: Text(b['logo']!, style: const TextStyle(color: AppColors.bottomBarCyan, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        title: Text('${b['bank']} - ${b['acc']}', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                        subtitle: Text(b['name']!, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        trailing: isSelected
                            ? const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.bottomBarCyan)
                            : const Icon(CupertinoIcons.circle, color: AppColors.textMutedDark),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final amt = double.tryParse(_amountCtrl.text) ?? 0;
                  if (amt < 20000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Số tiền rút tối thiểu là 20.000đ')),
                    );
                    return;
                  }
                  if (amt > _availableBalance) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Số tiền rút vượt quá số dư khả dụng')),
                    );
                    return;
                  }
                  final targetBank = _linkedBanks[_selectedBankIdx]['bank']!;
                  final targetAcc = _linkedBanks[_selectedBankIdx]['acc']!;
                  context.push('/withdraw/confirm?amount=$amt&bank=$targetBank&acc=$targetAcc');
                },
                child: const Text('Tiếp tục xác nhận rút tiền'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
