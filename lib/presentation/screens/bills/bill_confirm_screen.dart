import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class BillConfirmScreen extends StatefulWidget {
  final String? service;
  final String? provider;
  final String? code;

  const BillConfirmScreen({
    super.key,
    this.service,
    this.provider,
    this.code,
  });

  @override
  State<BillConfirmScreen> createState() => _BillConfirmScreenState();
}

class _BillConfirmScreenState extends State<BillConfirmScreen> {
  final double _billAmount = 485000;
  bool _autoPayNextMonth = true;

  void _proceedPayment() {
    final title = '${widget.service ?? "Hóa đơn"} - ${widget.provider ?? "EVN"}';
    context.push(
      '/transfer/confirm?recipient=$title (${widget.code ?? "PE0100023456"})&amount=$_billAmount&note=Thanh toan cuoc ${widget.code ?? ""}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Thông Tin Cước'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bill Summary Card
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Số tiền cần thanh toán', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      const SizedBox(height: 6),
                      Text(
                        CurrencyFormatter.formatVND(_billAmount),
                        style: AppTypography.displayMedium(color: AppColors.primaryLight),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Chờ thanh toán', style: TextStyle(color: AppColors.accentGold, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(height: 32, color: AppColors.cardBorderDark),

                      _buildRow('Dịch vụ', widget.service ?? 'Tiền điện'),
                      const SizedBox(height: 12),
                      _buildRow('Đơn vị cung cấp', widget.provider ?? 'EVN Hà Nội'),
                      const SizedBox(height: 12),
                      _buildRow('Mã khách hàng', widget.code ?? 'PE0100023456'),
                      const SizedBox(height: 12),
                      _buildRow('Tên chủ hộ', 'NGUYEN VAN B'),
                      const SizedBox(height: 12),
                      _buildRow('Địa chỉ', 'Số 18 Phố Huế, Q. Hoàn Kiếm, HN'),
                      const SizedBox(height: 12),
                      _buildRow('Kỳ cước', 'Tháng 08/2026'),
                      const SizedBox(height: 12),
                      _buildRow('Chiết khấu Sen Hồng', '-15.000đ (3%)', isHighlight: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Auto-debit Switch
              GlassCard(
                quality: GlassQuality.minimal,
                child: SwitchListTile.adaptive(
                  value: _autoPayNextMonth,
                  activeTrackColor: AppColors.primary,
                  title: Text('Tự động thanh toán kỳ sau', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                  subtitle: Text('Hệ thống sẽ tự động trừ cước khi có hóa đơn mới', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                  onChanged: (val) => setState(() => _autoPayNextMonth = val),
                ),
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _proceedPayment,
                child: const Text('Thanh toán ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
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
