import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '0901234567');
  bool _isLoading = false;

  void _handleSendOtp() {
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điện thoại đã đăng ký')),
      );
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.push('/auth/reset-password?phone=${_phoneController.text.trim()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Quên Mật Khẩu'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Iconsax.unlock, color: AppColors.primary, size: 40),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Lấy lại mật khẩu',
                style: AppTypography.displaySmall(color: AppColors.textPrimaryDark),
              ),
              const SizedBox(height: 8),
              Text(
                'Nhập số điện thoại tài khoản của bạn. Hệ thống sẽ gửi mã xác thực OTP 6 số để tiến hành đặt lại mật khẩu mới.',
                style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
              ),
              const SizedBox(height: 32),

              Text('Số điện thoại', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.call, color: AppColors.primary),
                  hintText: 'Nhập số điện thoại đã đăng ký',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 36),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleSendOtp,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Gửi mã OTP xác nhận'),
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/auth/login');
                    }
                  },
                  child: const Text('Quay lại đăng nhập', style: TextStyle(color: AppColors.primaryLight)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
