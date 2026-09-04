import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController(text: 'BÙI ĐỨC VƯƠNG');
  final TextEditingController _emailCtrl = TextEditingController(text: 'buiducvuong@example.com');
  final TextEditingController _dobCtrl = TextEditingController(text: '15/08/2004');
  final TextEditingController _phoneCtrl = TextEditingController(text: '0901234567');
  bool _isEditing = false;

  void _saveProfile() {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Cập nhật hồ sơ cá nhân thành công!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Hồ Sơ Cá Nhân'),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
            child: Text(_isEditing ? 'Lưu' : 'Chỉnh sửa', style: const TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Avatar with camera icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.bottomBarGlow.withOpacity(0.40),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 48,
                        backgroundColor: Color(0xFF0F172A),
                        child: Icon(Iconsax.profile_circle_copy, size: 55, color: AppColors.primaryLight),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Iconsax.camera_copy, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text('BÙI ĐỨC VƯƠNG', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 4),

              // KYC Badge
              InkWell(
                onTap: () => context.push('/profile/kyc-level'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.emeraldGreen.withOpacity(0.4)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.verify_copy, color: AppColors.emeraldGreen, size: 16),
                      SizedBox(width: 6),
                      Text('Đã Định Danh eKYC (Cấp 2)', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Iconsax.arrow_right_3, color: AppColors.emeraldGreen, size: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Profile Details
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildField('Họ và tên', _nameCtrl, Iconsax.user, enabled: _isEditing),
                      const SizedBox(height: 14),
                      _buildField('Số điện thoại', _phoneCtrl, Iconsax.call, enabled: false),
                      const SizedBox(height: 14),
                      _buildField('Email', _emailCtrl, Iconsax.sms, enabled: _isEditing),
                      const SizedBox(height: 14),
                      _buildField('Ngày sinh', _dobCtrl, Iconsax.calendar, enabled: _isEditing),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Navigation to Identity Documents & KYC Level
              GlassCard(
                quality: GlassQuality.minimal,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => context.push('/profile/identity'),
                      leading: const Icon(Iconsax.document_text_copy, color: AppColors.primary),
                      title: Text('Thông tin giấy tờ CCCD', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text('CCCD gắn chip: 001204018899', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.cardBorderDark),
                    ListTile(
                      onTap: () => context.push('/profile/kyc-level'),
                      leading: const Icon(Iconsax.chart_2, color: AppColors.accentGold),
                      title: Text('Hạn mức giao dịch (Kyc Level)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text('Hạn mức hiện tại: 100.000.000đ/ngày', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.cardBorderDark),
                    ListTile(
                      onTap: () => context.push('/profile/digital-signature'),
                      leading: const Icon(Iconsax.security_safe, color: AppColors.vividTeal),
                      title: Text('Chữ ký số & Smart OTP', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text('Chứng thư số cá nhân PKI', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    ),
                    const Divider(height: 1, indent: 56, color: AppColors.cardBorderDark),
                    ListTile(
                      onTap: () => context.push('/profile/email-settings'),
                      leading: const Icon(Iconsax.direct_send, color: AppColors.softPurple),
                      title: Text('Cài đặt Email nhận hóa đơn VAT', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                      subtitle: Text('Nhận sao kê định kỳ & biên lai điện tử', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      trailing: const Icon(Iconsax.arrow_right_3, color: AppColors.textMutedDark, size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, IconData icon, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          enabled: enabled,
          style: TextStyle(color: enabled ? Colors.white : AppColors.textMutedDark, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: const Color(0xFF1E293B),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
