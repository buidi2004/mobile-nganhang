import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountCtrl = TextEditingController(text: '500000');
  int _selectedSource = 0;

  final List<double> _quickAmounts = [100000, 200000, 500000, 1000000, 2000000, 5000000];

  final List<Map<String, String>> _sources = const [
    {'bank': 'Vietcombank', 'num': '*8899', 'type': 'Thẻ liên kết chính (Miễn phí)'},
    {'bank': 'Techcombank', 'num': '*6688', 'type': 'Tài khoản ngân hàng (Miễn phí)'},
    {'bank': 'Visa / Mastercard', 'num': '*1234', 'type': 'Thẻ quốc tế (Phí 1.5%)'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Nạp Tiền Vào Ví'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nhập số tiền cần nạp', style: AppTypography.titleMedium(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                style: AppTypography.displayMedium(color: AppColors.primaryLight),
                decoration: const InputDecoration(
                  suffixText: ' đ',
                  suffixStyle: TextStyle(color: AppColors.primaryLight, fontSize: 24),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              // Quick Amount Pills
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _quickAmounts.map((amt) {
                  return ActionChip(
                    label: Text(CurrencyFormatter.formatVND(amt)),
                    backgroundColor: AppColors.cardDark,
                    labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
                    onPressed: () => setState(() => _amountCtrl.text = amt.toInt().toString()),
                  );
                }).toList(),
              ),

              const SizedBox(height: 28),
              Text('Chọn nguồn tiền nạp', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 12),

              ...List.generate(_sources.length, (idx) {
                final s = _sources[idx];
                final isSelected = _selectedSource == idx;
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
                      child: Material(type: MaterialType.transparency, child: ListTile(
                        onTap: () => setState(() => _selectedSource = idx),
                        leading: Icon(CupertinoIcons.creditcard_fill, color: isSelected ? AppColors.bottomBarCyan : AppColors.textSecondaryDark),
                        title: Text('${s['bank']} (${s['num']})', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                        subtitle: Text(s['type']!, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        trailing: isSelected
                            ? const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.bottomBarCyan)
                            : const Icon(CupertinoIcons.circle, color: AppColors.textMutedDark),
                      )),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  final amt = double.tryParse(_amountCtrl.text) ?? 0;
                  if (amt < 10000) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Số tiền nạp tối thiểu là 10.000đ')),
                    );
                    return;
                  }
                  final source = _sources[_selectedSource]['bank']!;
                  context.push('/deposit/confirm?amount=$amt&source=$source');
                },
                child: const Text('Tiếp tục xác nhận'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
