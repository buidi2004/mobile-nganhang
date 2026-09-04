import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class TransferConfirmScreen extends StatefulWidget {
  final String recipient;
  final double amount;
  final String note;

  const TransferConfirmScreen({
    super.key,
    required this.recipient,
    required this.amount,
    required this.note,
  });

  @override
  State<TransferConfirmScreen> createState() => _TransferConfirmScreenState();
}

class _TransferConfirmScreenState extends State<TransferConfirmScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsLeft = 60;
  Timer? _timer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ 6 số mã xác thực 2FA OTP')),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go('/transfer/result?recipient=${widget.recipient}&amount=${widget.amount}&note=${widget.note}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Xác Thực Giao Dịch (2FA)'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.shield_security, color: AppColors.primary, size: 32),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bảo mật 2 lớp giá trị cao', style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                          const SizedBox(height: 2),
                          Text(
                            'Giao dịch ${CurrencyFormatter.formatVND(widget.amount)} yêu cầu xác thực OTP gửi qua SMS tới số đăng ký.',
                            style: AppTypography.bodySmall(color: AppColors.textSecondaryDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              Text('Nhập mã OTP 6 số', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 6),
              Text('Kiểm tra tin nhắn SMS từ SEN HỒNG trên điện thoại của bạn', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 20),

              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: AppColors.primaryLight, fontSize: 24, letterSpacing: 10, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  counterText: '',
                  prefixIcon: const Icon(Iconsax.lock_1, color: AppColors.primary),
                  hintText: '• • • • • •',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark, letterSpacing: 6),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _secondsLeft > 0 ? 'Mã hết hạn sau: ${_secondsLeft}s' : 'Mã OTP đã hết hạn',
                    style: TextStyle(color: _secondsLeft > 0 ? AppColors.textSecondaryDark : AppColors.error),
                  ),
                  TextButton(
                    onPressed: _secondsLeft == 0 ? _startCountdown : null,
                    child: const Text('Gửi lại mã'),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleConfirm,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Xác nhận & Chuyển tiền'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
