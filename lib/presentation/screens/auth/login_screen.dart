import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '0901234567');
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Navigator.of(context).canPop())
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                )
              else
                const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.bottomBarCyan.withOpacity(0.25),
                        AppColors.bottomBarOcean.withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bottomBarCyan, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bottomBarGlow.withOpacity(0.35),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: const Icon(Iconsax.shield_security, color: AppColors.bottomBarCyan, size: 36),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('SEN HỒNG BANK', style: AppTypography.displaySmall(color: AppColors.primaryLight)),
              ),
              Center(
                child: Text('Ví Điện Tử Tài Chính Số', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              ),
              const SizedBox(height: 40),

              Text('Đăng nhập', style: AppTypography.displayMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              Text('Chào mừng bạn quay trở lại với Sen Hồng', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 28),

              // Phone Field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
                  prefixIcon: const Icon(Iconsax.call, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
                  prefixIcon: const Icon(Iconsax.lock_1, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Iconsax.eye_slash : Iconsax.eye, color: AppColors.textSecondaryDark),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/auth/forgot-password'),
                  child: const Text('Quên mật khẩu?', style: TextStyle(color: AppColors.primaryLight)),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 16),

              // Biometric Option
              Center(
                child: IconButton(
                  onPressed: () => context.go('/'),
                  iconSize: 52,
                  icon: const Icon(Iconsax.finger_scan, color: AppColors.emeraldGreen),
                  tooltip: 'Đăng nhập sinh trắc học FaceID / Vân tay',
                ),
              ),
              Center(
                child: Text('Đăng nhập bằng FaceID / Vân tay', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              ),

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chưa có tài khoản ví?', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                  TextButton(
                    onPressed: () => context.push('/auth/register'),
                    child: const Text('Đăng ký ngay', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
