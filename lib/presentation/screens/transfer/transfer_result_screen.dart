import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class TransferResultScreen extends StatelessWidget {
  final String recipient;
  final double amount;
  final String note;

  const TransferResultScreen({
    super.key,
    required this.recipient,
    required this.amount,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} - ${now.day}/${now.month}/${now.year}';
    const txId = 'SHB-8839219084';

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Success Animation Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.emeraldGreen.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.emeraldGreen, width: 2),
                ),
                child: const Icon(CupertinoIcons.checkmark_alt, color: AppColors.emeraldGreen, size: 48),
              ),
              const SizedBox(height: 16),

              Text('Giao Dịch Thành Công', style: AppTypography.displaySmall(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 6),
              Text(timeStr, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 20),

              Text(
                CurrencyFormatter.formatVND(amount),
                style: AppTypography.displayLarge(color: AppColors.emeraldGreen),
              ),
              const SizedBox(height: 24),

              // Receipt GlassCard
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildReceiptRow('Mã giao dịch', txId),
                      const Divider(height: 16, color: AppColors.cardBorderDark),
                      _buildReceiptRow('Người thụ hưởng', recipient),
                      const Divider(height: 16, color: AppColors.cardBorderDark),
                      _buildReceiptRow('Phương thức', 'Ví tới Ví Sen Hồng'),
                      const Divider(height: 16, color: AppColors.cardBorderDark),
                      _buildReceiptRow('Lời nhắn', note),
                      const Divider(height: 16, color: AppColors.cardBorderDark),
                      _buildReceiptRow('Số dư ví sau GD', '12.430.000 đ'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // PDF Receipt & Share
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đang tải biên lai PDF...')),
                        );
                      },
                      icon: const Icon(CupertinoIcons.doc_text_fill, size: 18),
                      label: const Text('Tải biên lai PDF'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.cardBorderDark),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.share, size: 18),
                      label: const Text('Chia sẻ ảnh'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.cardBorderDark),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Về màn hình chính'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
        Text(value, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
      ],
    );
  }
}
