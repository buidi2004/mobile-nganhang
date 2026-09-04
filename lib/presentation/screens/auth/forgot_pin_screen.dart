import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  int _currentStep = 1; // 1: OTP, 2: New PIN
  final TextEditingController _otpCtrl = TextEditingController();
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _isLoading = false;

  void _verifyOtp() {
    if (_otpCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ 6 số OTP xác minh')),
      );
      return;
    }
    setState(() {
      _currentStep = 2;
    });
  }

  void _handleKeyPress(String value) {
    if (!_isConfirming) {
      if (_pin.length < 6) {
        setState(() => _pin += value);
        if (_pin.length == 6) {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() => _isConfirming = true);
          });
        }
      }
    } else {
      if (_confirmPin.length < 6) {
        setState(() => _confirmPin += value);
        if (_confirmPin.length == 6) {
          _submitNewPin();
        }
      }
    }
  }

  void _handleBackspace() {
    setState(() {
      if (_isConfirming) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          _isConfirming = false;
        }
      } else {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      }
    });
  }

  void _submitNewPin() {
    if (_pin != _confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.error,
          content: Text('Mã PIN xác nhận không khớp! Vui lòng nhập lại.'),
        ),
      );
      setState(() {
        _confirmPin = '';
        _isConfirming = false;
        _pin = '';
      });
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.emeraldGreen,
          content: Text('Đặt lại mã PIN thành công!'),
        ),
      );
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/settings/security');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cấp Lại Mã PIN'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: _currentStep == 1 ? _buildOtpStep() : _buildPinStep(),
      ),
    );
  }

  Widget _buildOtpStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Iconsax.shield_security, color: AppColors.primary, size: 36),
            ),
          ),
          const SizedBox(height: 24),
          Text('Xác minh danh tính', style: AppTypography.displaySmall(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 8),
          Text(
            'Hệ thống đã gửi mã xác thực OTP 6 số đến số điện thoại đăng ký tài khoản của bạn để xác thực yêu cầu cấp lại mã PIN.',
            style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
          ),
          const SizedBox(height: 32),

          Text('Mã OTP xác thực', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 8),
          TextField(
            controller: _otpCtrl,
            keyboardType: TextInputType.number,
            maxLength: 6,
            style: const TextStyle(color: AppColors.primaryLight, fontSize: 22, letterSpacing: 8, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              hintText: '• • • • • •',
              hintStyle: const TextStyle(color: AppColors.textMutedDark, letterSpacing: 6),
              filled: true,
              fillColor: AppColors.cardDark,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _verifyOtp,
            child: const Text('Xác nhận & Đặt lại PIN'),
          ),
        ],
      ),
    );
  }

  Widget _buildPinStep() {
    final activeLength = _isConfirming ? _confirmPin.length : _pin.length;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          _isConfirming ? 'Xác nhận lại mã PIN mới' : 'Thiết lập mã PIN mới',
          style: AppTypography.displaySmall(color: AppColors.textPrimaryDark),
        ),
        const SizedBox(height: 8),
        Text(
          _isConfirming ? 'Nhập lại 6 chữ số để xác nhận' : 'Mã PIN gồm 6 số dùng để ký chuyển tiền',
          style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
        ),
        const SizedBox(height: 32),

        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            final isFilled = index < activeLength;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isFilled ? AppColors.primary : AppColors.textMutedDark,
                  width: 2,
                ),
              ),
            );
          }),
        ),

        const Spacer(),

        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(color: AppColors.primary),
          )
        else
          // Numpad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                _buildRow(['1', '2', '3']),
                const SizedBox(height: 16),
                _buildRow(['4', '5', '6']),
                const SizedBox(height: 16),
                _buildRow(['7', '8', '9']),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 72, height: 72),
                    _buildNumpadButton('0'),
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: IconButton(
                        icon: const Icon(Iconsax.arrow_left_2, color: Colors.white70, size: 28),
                        onPressed: _handleBackspace,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: values.map((v) => _buildNumpadButton(v)).toList(),
    );
  }

  Widget _buildNumpadButton(String value) {
    return InkWell(
      onTap: () => _handleKeyPress(value),
      borderRadius: BorderRadius.circular(36),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cardBorderDark),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
