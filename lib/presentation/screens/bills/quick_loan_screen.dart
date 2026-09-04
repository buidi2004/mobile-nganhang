import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class QuickLoanScreen extends StatefulWidget {
  const QuickLoanScreen({super.key});

  @override
  State<QuickLoanScreen> createState() => _QuickLoanScreenState();
}

class _QuickLoanScreenState extends State<QuickLoanScreen> {
  double _loanAmount = 15000000;
  int _loanMonths = 6;
  final double _monthlyInterestRate = 0.012; // 1.2%/tháng

  double get _monthlyPrincipal => _loanAmount / _loanMonths;
  double get _monthlyInterest => _loanAmount * _monthlyInterestRate;
  double get _monthlyTotal => _monthlyPrincipal + _monthlyInterest;

  bool _agreeTerms = true;
  bool _isLoading = false;

  void _submitApplication() {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đồng ý với điều khoản hợp đồng vay')),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.cardDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.emeraldGreen),
              SizedBox(width: 8),
              Text('Đăng ký thành công!', style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
          content: Text(
            'Hồ sơ vay tiêu dùng nhanh ${CurrencyFormatter.formatVND(_loanAmount)} của bạn đã được gửi. Hệ thống AI chấm điểm tín dụng tự động phê duyệt và giải ngân vào ví trong vòng 15 phút.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.go('/');
              },
              child: const Text('Về trang chủ'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Vay Nhanh Tiêu Dùng'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Loan Limit Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF032B43), Color(0xFF0077B6), Color(0xFF00B4D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.bottomBarCyan.withOpacity(0.4), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bottomBarGlow.withOpacity(0.20),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.bolt_badge_a_fill, color: AppColors.accentGold, size: 36),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('HẠN MỨC ĐƯỢC DUYỆT TỰ ĐỘNG', style: AppTypography.labelLarge(color: AppColors.accentGold)),
                          const SizedBox(height: 2),
                          const Text('Lên đến 50.000.000 đ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('Giải ngân thần tốc sau 15 phút • Không cần thế chấp', style: AppTypography.bodySmall(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Loan Amount Slider
              Text('Số tiền muốn vay', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 6),
              Text(
                CurrencyFormatter.formatVND(_loanAmount),
                style: AppTypography.displayMedium(color: AppColors.primaryLight),
              ),
              Slider(
                value: _loanAmount,
                min: 5000000,
                max: 50000000,
                divisions: 9,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.cardBorderDark,
                onChanged: (val) => setState(() => _loanAmount = val),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('5.000.000 đ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                  Text('50.000.000 đ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                ],
              ),
              const SizedBox(height: 24),

              // Loan Term
              Text('Kỳ hạn trả góp', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [3, 6, 9, 12, 18].map((m) {
                  final isSelected = _loanMonths == m;
                  return ChoiceChip(
                    label: Text('$m tháng'),
                    selected: isSelected,
                    onSelected: (v) => setState(() => _loanMonths = m),
                    selectedColor: AppColors.primary,
                  );
                }).toList(),
              ),

              const SizedBox(height: 28),

              // Monthly Repayment Details Card
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lịch trả nợ ước tính hàng tháng', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Trả hàng tháng (Gốc + Lãi):', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                          Text(CurrencyFormatter.formatVND(_monthlyTotal), style: AppTypography.titleLarge(color: AppColors.emeraldGreen)),
                        ],
                      ),
                      const Divider(height: 24, color: AppColors.cardBorderDark),
                      _buildRow('Tiền gốc hàng tháng', CurrencyFormatter.formatVND(_monthlyPrincipal)),
                      const SizedBox(height: 8),
                      _buildRow('Tiền lãi hàng tháng (1.2%)', CurrencyFormatter.formatVND(_monthlyInterest)),
                      const SizedBox(height: 8),
                      _buildRow('Tổng lãi cả kỳ', CurrencyFormatter.formatVND(_monthlyInterest * _loanMonths)),
                      const SizedBox(height: 8),
                      _buildRow('Phí thẩm định hồ sơ', 'Miễn phí (0đ)', isGreen: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Agreement
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _agreeTerms,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _agreeTerms = v ?? true),
                title: const Text(
                  'Tôi đồng ý với điều khoản hợp đồng tín dụng và ủy quyền tra cứu CIC tự động.',
                  style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 12),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitApplication,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Nộp hồ sơ vay ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 13)),
        Text(value, style: TextStyle(color: isGreen ? AppColors.emeraldGreen : Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
