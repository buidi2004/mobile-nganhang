import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountCtrl = TextEditingController(text: '500000');
  int _selectedSource = 0;

  final List<Map<String, String>> _sources = const [
    {'bank': 'Vietcombank', 'num': '*8899', 'type': 'Thẻ liên kết chính'},
    {'bank': 'Techcombank', 'num': '*6688', 'type': 'Tài khoản ngân hàng'},
    {'bank': 'Visa / Mastercard', 'num': '*1234', 'type': 'Thẻ thanh toán quốc tế'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Nạp Tiền Vào Ví')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nhập số tiền nạp', style: AppTypography.titleMedium(color: AppColors.textSecondaryDark)),
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
              const SizedBox(height: 24),
              Text('Chọn nguồn tiền', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 12),
              ...List.generate(_sources.length, (idx) {
                final s = _sources[idx];
                final isSelected = _selectedSource == idx;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    quality: GlassQuality.minimal,
                    child: ListTile(
                      onTap: () => setState(() => _selectedSource = idx),
                      leading: Icon(CupertinoIcons.creditcard_fill, color: isSelected ? AppColors.primary : AppColors.textSecondaryDark),
                      title: Text('${s['bank']} (${s['num']})', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text(s['type']!, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: isSelected
                          ? const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.primary)
                          : const Icon(CupertinoIcons.circle, color: AppColors.textMutedDark),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final amt = double.tryParse(_amountCtrl.text) ?? 0;
                  context.push('/transfer/confirm?recipient=Nạp Ví Sen Hồng&amount=$amt&note=Nap tien tu ${_sources[_selectedSource]['bank']}');
                },
                child: const Text('Nạp tiền ngay (Miễn phí)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
