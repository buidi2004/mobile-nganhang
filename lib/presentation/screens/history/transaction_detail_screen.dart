import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String? id;
  final String? title;
  final double? amount;
  final String? time;
  final String? note;
  final String? recipient;

  const TransactionDetailScreen({
    super.key,
    this.id,
    this.title,
    this.amount,
    this.time,
    this.note,
    this.recipient,
  });

  @override
  Widget build(BuildContext context) {
    final txId = id ?? 'TX202609058866';
    final txTitle = title ?? 'Chuyển tiền Napas 247';
    final txAmount = amount ?? -150000.0;
    final txTime = time ?? '10:30 - 05/09/2026';
    final txNote = note ?? 'Chuyen tien thanh toan';
    final txRecipient = recipient ?? 'NGUYEN VAN A (VCB *8899)';
    final isPositive = txAmount > 0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Chi Tiết Giao Dịch'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã sao chép liên kết chia sẻ biên lai giao dịch')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Receipt Container
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.emeraldGreen.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.emeraldGreen, size: 36),
                      ),
                      const SizedBox(height: 12),
                      Text('GIAO DỊCH THÀNH CÔNG', style: AppTypography.titleMedium(color: AppColors.emeraldGreen)),
                      const SizedBox(height: 8),
                      Text(
                        '${isPositive ? '+' : ''}${CurrencyFormatter.formatVND(txAmount)}',
                        style: AppTypography.displayMedium(
                          color: isPositive ? AppColors.emeraldGreen : AppColors.textPrimaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(txTitle, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      const Divider(height: 36, color: AppColors.cardBorderDark),

                      _buildDetailRow('Mã giao dịch', txId),
                      const SizedBox(height: 12),
                      _buildDetailRow('Thời gian', txTime),
                      const SizedBox(height: 12),
                      _buildDetailRow('Người thụ hưởng', txRecipient),
                      const SizedBox(height: 12),
                      _buildDetailRow('Nội dung', txNote),
                      const SizedBox(height: 12),
                      _buildDetailRow('Nguồn tiền', 'Ví Sen Hồng chính (*6688)'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Phí giao dịch', '0 VND (Miễn phí)', isHighlight: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.cardBorderDark),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.cardDark,
                            content: Text('Đang tải xuống biên lai PDF: receipt_$txId.pdf...'),
                          ),
                        );
                      },
                      icon: const Icon(CupertinoIcons.arrow_down_doc_fill, size: 18, color: Colors.white),
                      label: const Text('Tải biên lai PDF', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final positiveAmt = txAmount.abs();
                        context.push('/transfer/amount?recipient=$txRecipient&amount=$positiveAmt&note=$txNote');
                      },
                      icon: const Icon(CupertinoIcons.arrow_2_squarepath, size: 18),
                      label: const Text('Chuyển lại'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.titleSmall(
              color: isHighlight ? AppColors.emeraldGreen : AppColors.textPrimaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
