import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class DepositConfirmScreen extends StatefulWidget {
  final double amount;
  final String source;

  const DepositConfirmScreen({
    super.key,
    required this.amount,
    required this.source,
  });

  @override
  State<DepositConfirmScreen> createState() => _DepositConfirmScreenState();
}

class _DepositConfirmScreenState extends State<DepositConfirmScreen> {
  String _pin = '';
  bool _isLoading = false;

  void _handlePinInput(String digit) {
    if (_pin.length < 6) {
      setState(() => _pin += digit);
      if (_pin.length == 6) {
        _submitDeposit();
      }
    }
  }

  void _handleBackspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  void _submitDeposit() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go(
        '/transfer/result?recipient=Nạp Ví Sen Hồng&amount=${widget.amount}&note=Nạp tiền từ ${widget.source}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Xác Nhận Nạp Tiền'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // Glass Card Info
                    GlassCard(
                      quality: GlassQuality.minimal,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Số tiền nạp', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                            const SizedBox(height: 6),
                            Text(
                              CurrencyFormatter.formatVND(widget.amount),
                              style: AppTypography.displayMedium(color: AppColors.emeraldGreen),
                            ),
                            const Divider(height: 32, color: AppColors.cardBorderDark),
                            _buildRow('Nguồn nạp', widget.source),
                            const SizedBox(height: 12),
                            _buildRow('Tài khoản nhận', 'Ví Sen Hồng chính'),
                            const SizedBox(height: 12),
                            _buildRow('Phí giao dịch', 'Miễn phí (0đ)', isHighlight: true),
                            const SizedBox(height: 12),
                            _buildRow('Tổng tiền trừ', CurrencyFormatter.formatVND(widget.amount)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Nhập mã PIN 6 số để xác nhận nạp tiền', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    const SizedBox(height: 16),

                    // Pin Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (idx) {
                        final isFilled = idx < _pin.length;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled ? AppColors.primary : Colors.transparent,
                            border: Border.all(color: isFilled ? AppColors.primary : AppColors.textMutedDark, width: 2),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            else
              // Numpad
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 16),
                child: Column(
                  children: [
                    _buildNumpadRow(['1', '2', '3']),
                    const SizedBox(height: 12),
                    _buildNumpadRow(['4', '5', '6']),
                    const SizedBox(height: 12),
                    _buildNumpadRow(['7', '8', '9']),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 68, height: 68),
                        _buildNumpadBtn('0'),
                        SizedBox(
                          width: 68,
                          height: 68,
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.delete_left_fill, color: Colors.white70, size: 26),
                            onPressed: _handleBackspace,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
        Text(
          value,
          style: AppTypography.titleMedium(
            color: isHighlight ? AppColors.emeraldGreen : AppColors.textPrimaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: digits.map((d) => _buildNumpadBtn(d)).toList(),
    );
  }

  Widget _buildNumpadBtn(String digit) {
    return InkWell(
      onTap: () => _handlePinInput(digit),
      borderRadius: BorderRadius.circular(34),
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cardBorderDark),
        ),
        child: Center(
          child: Text(digit, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
