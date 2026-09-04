import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class EnterAmountScreen extends StatefulWidget {
  final String recipient;

  const EnterAmountScreen({super.key, required this.recipient});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController(text: 'Chuyen tien');
  final double _balance = 12580000;

  void _addAmount(double add) {
    final current = double.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final total = current + add;
    setState(() {
      _amountController.text = total.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final amountVal = double.tryParse(_amountController.text) ?? 0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Nhập Số Tiền')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient Badge
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        child: const Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.recipient, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                            const SizedBox(height: 2),
                            Text('Ví Sen Hồng • Đã xác thực KYC', style: AppTypography.bodySmall(color: AppColors.emeraldGreen)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Amount Input
              Center(
                child: Column(
                  children: [
                    Text('Số tiền chuyển', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                    const SizedBox(height: 8),
                    IntrinsicWidth(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        style: AppTypography.displayLarge(color: AppColors.primaryLight),
                        decoration: const InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(color: AppColors.textMutedDark),
                          suffixText: ' đ',
                          suffixStyle: TextStyle(fontSize: 24, color: AppColors.primaryLight),
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    Text(
                      'Số dư khả dụng: ${CurrencyFormatter.formatVND(_balance)}',
                      style: AppTypography.bodySmall(color: AppColors.textSecondaryDark),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Quick Amount Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickChip('+50.000', () => _addAmount(50000)),
                  _buildQuickChip('+100.000', () => _addAmount(100000)),
                  _buildQuickChip('+500.000', () => _addAmount(500000)),
                  _buildQuickChip('+1.000.000', () => _addAmount(1000000)),
                  _buildQuickChip('+2.000.000', () => _addAmount(2000000)),
                  _buildQuickChip('Tất cả', () => setState(() => _amountController.text = _balance.toStringAsFixed(0))),
                ],
              ),

              const SizedBox(height: 24),

              // Note Field
              TextField(
                controller: _noteController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Lời nhắn / Nội dung chuyển tiền',
                  prefixIcon: const Icon(CupertinoIcons.chat_bubble_text, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: amountVal > 0
                    ? () {
                        context.push(
                          '/transfer/confirm?recipient=${widget.recipient}&amount=$amountVal&note=${_noteController.text}',
                        );
                      }
                    : null,
                child: const Text('Tiếp tục'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip(String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textPrimaryDark)),
      backgroundColor: AppColors.cardDark,
      side: const BorderSide(color: AppColors.cardBorderDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onTap,
    );
  }
}
