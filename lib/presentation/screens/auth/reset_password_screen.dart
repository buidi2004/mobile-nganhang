import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? phone;
  const ResetPasswordScreen({super.key, this.phone});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;
  bool _isLoading = false;

  void _handleReset() {
    if (_otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ 6 chữ số mã OTP')),
      );
      return;
    }
    if (_passController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu mới phải có tối thiểu 6 ký tự')),
      );
      return;
    }
    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xác nhận mật khẩu không trùng khớp')),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.emeraldGreen,
          content: Text('Đổi mật khẩu thành công! Vui lòng đăng nhập lại.'),
        ),
      );
      context.go('/auth/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayPhone = widget.phone ?? '0901234567';

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Đặt Lại Mật Khẩu'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thiết lập mật khẩu mới',
                style: AppTypography.displaySmall(color: AppColors.textPrimaryDark),
              ),
              const SizedBox(height: 8),
              Text(
                'Mã OTP đã được gửi đến số điện thoại $displayPhone. Vui lòng nhập mã và thiết lập mật khẩu bảo mật mới.',
                style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
              ),
              const SizedBox(height: 28),

              // OTP field
              Text('Mã xác thực OTP (6 số)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: AppColors.primaryLight, fontSize: 20, letterSpacing: 8, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  counterText: '',
                  prefixIcon: const Icon(Iconsax.password_check, color: AppColors.primary),
                  hintText: '• • • • • •',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark, letterSpacing: 4),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // New Password
              Text('Mật khẩu mới', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _passController,
                obscureText: _obscurePass,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.lock_1, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePass ? Iconsax.eye_slash : Iconsax.eye, color: AppColors.textMutedDark),
                    onPressed: () => setState(() => _obscurePass = !_obscurePass),
                  ),
                  hintText: 'Tối thiểu 6 ký tự',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm New Password
              Text('Xác nhận mật khẩu mới', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPassController,
                obscureText: _obscureConfirmPass,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.shield_tick_copy, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPass ? Iconsax.eye_slash : Iconsax.eye, color: AppColors.textMutedDark),
                    onPressed: () => setState(() => _obscureConfirmPass = !_obscureConfirmPass),
                  ),
                  hintText: 'Nhập lại mật khẩu mới',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 36),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleReset,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Hoàn tất đặt lại mật khẩu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
