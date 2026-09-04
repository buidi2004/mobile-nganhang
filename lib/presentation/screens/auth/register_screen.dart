import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _agreeTerms = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Đăng Ký Tài Khoản')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mở ví Sen Hồng', style: AppTypography.displayMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 6),
              Text('Nhập thông tin cá nhân để bắt đầu trải nghiệm tài chính số', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 28),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Số điện thoại nhận OTP',
                  prefixIcon: const Icon(Iconsax.call, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Họ và tên (như trên CCCD)',
                  prefixIcon: const Icon(Iconsax.user, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mật khẩu (tối thiểu 6 ký tự)',
                  prefixIcon: const Icon(Iconsax.lock_1, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _agreeTerms = v ?? true),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => context.push('/auth/terms'),
                      child: Text('Tôi đồng ý với Điều khoản sử dụng & Chính sách bảo mật Sen Hồng', style: AppTypography.bodySmall(color: AppColors.primaryLight)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => context.push('/auth/otp?phone=${_phoneController.text}'),
                child: const Text('Tiếp tục & Nhận mã OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
