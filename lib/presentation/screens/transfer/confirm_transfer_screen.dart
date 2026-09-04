import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';
import 'package:sen_hong_bank/presentation/widgets/custom_pin_numpad.dart';

class ConfirmTransferScreen extends StatefulWidget {
  final String recipient;
  final double amount;
  final String note;

  const ConfirmTransferScreen({
    super.key,
    required this.recipient,
    required this.amount,
    required this.note,
  });

  @override
  State<ConfirmTransferScreen> createState() => _ConfirmTransferScreenState();
}

class _ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  bool _saveBeneficiary = true;
  bool _showPinModal = false;
  String _pin = '';

  void _onPinEntered(String val) {
    setState(() => _pin = val);
    if (val.length == 6) {
      // Giả lập xác thực ký mã PIN thành công
      context.go(
        '/transfer/result?recipient=${widget.recipient}&amount=${widget.amount}&note=${widget.note}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Xác Nhận Giao Dịch')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Summary
              Center(
                child: Column(
                  children: [
                    Text('Tổng tiền thanh toán', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                    const SizedBox(height: 6),
                    Text(
                      CurrencyFormatter.formatVND(widget.amount),
                      style: AppTypography.displayLarge(color: AppColors.primaryLight),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Details Card (GlassCard)
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildInfoRow('Người nhận', widget.recipient),
                      const Divider(height: 20, color: AppColors.cardBorderDark),
                      _buildInfoRow('Phương thức', 'Ví Sen Hồng (Nội bộ)'),
                      const Divider(height: 20, color: AppColors.cardBorderDark),
                      _buildInfoRow('Phí giao dịch', 'Miễn phí (0đ)', valueColor: AppColors.emeraldGreen),
                      const Divider(height: 20, color: AppColors.cardBorderDark),
                      _buildInfoRow('Nội dung', widget.note),
                      const Divider(height: 20, color: AppColors.cardBorderDark),
                      _buildInfoRow('Nguồn tiền', 'Ví chính (Số dư khả dụng: 12.580.000đ)'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Checkbox(
                    value: _saveBeneficiary,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _saveBeneficiary = v ?? true),
                  ),
                  Text('Lưu vào danh bạ người thụ hưởng', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                ],
              ),

              const SizedBox(height: 24),

              if (!_showPinModal)
                ElevatedButton(
                  onPressed: () => setState(() => _showPinModal = true),
                  child: const Text('Xác nhận & Nhập mã PIN'),
                )
              else ...[
                Text('Nhập mã PIN 6 số để ký giao dịch', textAlign: TextAlign.center, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                const SizedBox(height: 16),
                CustomPinNumpad(
                  pin: _pin,
                  maxDigits: 6,
                  showBiometric: true,
                  onPinChanged: _onPinEntered,
                  onBiometricPressed: () {
                    // FaceID ký giao dịch thành công
                    context.go(
                      '/transfer/result?recipient=${widget.recipient}&amount=${widget.amount}&note=${widget.note}',
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.titleMedium(color: valueColor ?? AppColors.textPrimaryDark),
          ),
        ),
      ],
    );
  }
}
