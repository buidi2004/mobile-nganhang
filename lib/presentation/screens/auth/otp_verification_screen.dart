import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/presentation/widgets/custom_pin_numpad.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? phone;

  const OtpVerificationScreen({super.key, this.phone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _otp = '';

  void _onOtpChanged(String value) {
    setState(() => _otp = value);
    if (value.length == 6) {
      // Xác thực OTP thành công -> chuyển sang tạo PIN
      context.push('/auth/set-pin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Xác Thực OTP')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Nhập mã xác thực', style: AppTypography.displaySmall(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 8),
            Text(
              'Mã OTP 6 số đã được gửi tới ${widget.phone ?? "số điện thoại của bạn"}',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
            ),
            const Spacer(),
            CustomPinNumpad(
              pin: _otp,
              maxDigits: 6,
              onPinChanged: _onOtpChanged,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Gửi lại mã OTP (58s)', style: TextStyle(color: AppColors.primary)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
