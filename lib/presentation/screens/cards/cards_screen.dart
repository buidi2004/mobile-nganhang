import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool _isLocked = false;
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Thẻ Sen Hồng'),
        actions: [
          IconButton(
            onPressed: () => context.push('/payment-methods'),
            icon: const Icon(Iconsax.card_add, color: AppColors.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Virtual Card Hero (GlassCard Premium)
              GlassCard(
                quality: GlassQuality.premium, // Hero section - shader khúc xạ & phản xạ ánh sáng cao cấp
                settings: const LiquidGlassSettings(
                  specularSharpness: GlassSpecularSharpness.medium,
                ),
                child: Container(
                  height: 220,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.bottomBarCyan.withOpacity(0.35), width: 1.2),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF032B43), Color(0xFF005F73), Color(0xFF0096C7), Color(0xFF26E5DC)],
                      stops: [0.0, 0.35, 0.75, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bottomBarGlow.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(CupertinoIcons.bolt_horizontal_circle_fill,
                                  color: AppColors.accentGold, size: 28),
                              const SizedBox(width: 8),
                              Text(
                                'SEN HỒNG PLATINUM',
                                style: AppTypography.labelLarge(color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            _isLocked ? 'ĐÃ KHÓA' : 'HOẠT ĐỘNG',
                            style: TextStyle(
                              color: _isLocked ? Colors.redAccent : AppColors.emeraldGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.accentGold.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(Iconsax.card, color: Colors.black54, size: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.contactless, color: Colors.white70, size: 28),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _showDetails ? '9704 2200 8899 6688' : '•••• •••• •••• 6688',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'BÙI ĐỨC VƯƠNG',
                                style: AppTypography.bodySmall(color: Colors.white70),
                              ),
                              Text(
                                _showDetails ? '12/29' : '••/••',
                                style: AppTypography.bodySmall(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Actions List
              Text('Quản lý thẻ', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 12),

              _buildCardOption(
                icon: _showDetails ? Iconsax.eye_slash : Iconsax.eye,
                title: 'Xem thông tin thẻ & CVV',
                subtitle: 'Hiển thị đầy đủ số thẻ và ngày hết hạn',
                trailing: Switch.adaptive(
                  value: _showDetails,
                  activeTrackColor: AppColors.primary,
                  onChanged: (val) => setState(() => _showDetails = val),
                ),
              ),

              _buildCardOption(
                icon: _isLocked ? Iconsax.unlock : Iconsax.lock_1,
                title: _isLocked ? 'Mở khóa thẻ' : 'Khóa thẻ tạm thời',
                subtitle: _isLocked ? 'Thẻ đang bị khóa giao dịch' : 'Bảo vệ thẻ khi nghi ngờ lộ thông tin',
                trailing: Switch.adaptive(
                  value: _isLocked,
                  activeTrackColor: AppColors.error,
                  onChanged: (val) => setState(() => _isLocked = val),
                ),
              ),

              _buildCardOption(
                icon: Iconsax.shield_security,
                title: 'Đổi mã PIN thẻ',
                subtitle: 'Thay đổi PIN rút tiền tại cây ATM',
                onTap: () => context.push('/auth/set-pin'),
              ),

              _buildCardOption(
                icon: Iconsax.setting_4,
                title: 'Cài đặt hạn mức thanh toán',
                subtitle: 'Hạn mức chi tiêu trực tuyến mỗi ngày',
                onTap: () => context.push('/profile/kyc-level'),
              ),

              _buildCardOption(
                icon: Iconsax.cards,
                title: 'Nguồn tiền & Phương thức thanh toán',
                subtitle: 'Liên kết thẻ Visa, Mastercard, JCB quốc tế',
                onTap: () => context.push('/payment-methods'),
              ),

              _buildCardOption(
                icon: Iconsax.bank,
                title: 'Tài khoản ngân hàng nội địa',
                subtitle: 'Quản lý tài khoản ngân hàng liên kết',
                onTap: () => context.push('/bank-cards'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardOption({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        quality: GlassQuality.minimal,
        child: Material(type: MaterialType.transparency, child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          title: Text(title, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
          subtitle: Text(subtitle, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
          trailing: trailing ?? const Icon(Iconsax.arrow_right_3, size: 18, color: AppColors.textMutedDark),
        )),
      ),
    );
  }
}
