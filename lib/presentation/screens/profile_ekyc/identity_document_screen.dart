import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class IdentityDocumentScreen extends StatelessWidget {
  const IdentityDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Giấy Tờ Tùy Thân (CCCD)'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Badge Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.emeraldGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.emeraldGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.emeraldGreen, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ĐÃ PHÊ DUYỆT ĐỊNH DANH', style: AppTypography.titleMedium(color: AppColors.emeraldGreen)),
                          const SizedBox(height: 2),
                          Text(
                            'Giấy tờ CCCD gắn chip của bạn đã được xác thực thành công qua cổng dữ liệu dân cư quốc gia.',
                            style: AppTypography.bodySmall(color: AppColors.textSecondaryDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Document Details Card
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thông tin định danh CCCD', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                      const Divider(height: 24, color: AppColors.cardBorderDark),
                      _buildRow('Loại giấy tờ', 'Căn cước công dân gắn chip'),
                      const SizedBox(height: 12),
                      _buildRow('Số CCCD', '001204018899'),
                      const SizedBox(height: 12),
                      _buildRow('Họ và tên', 'BÙI ĐỨC VƯƠNG'),
                      const SizedBox(height: 12),
                      _buildRow('Ngày sinh', '15/08/2004'),
                      const SizedBox(height: 12),
                      _buildRow('Giới tính', 'Nam'),
                      const SizedBox(height: 12),
                      _buildRow('Quốc tịch', 'Việt Nam'),
                      const SizedBox(height: 12),
                      _buildRow('Địa chỉ thường trú', 'P. Hàng Bạc, Q. Hoàn Kiếm, Hà Nội'),
                      const SizedBox(height: 12),
                      _buildRow('Ngày cấp', '20/09/2021'),
                      const SizedBox(height: 12),
                      _buildRow('Nơi cấp', 'Cục Cảnh sát QLHC về TTXH (C06)'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => context.push('/profile/ekyc'),
                icon: const Icon(CupertinoIcons.arrow_2_circlepath),
                label: const Text('Cập nhật lại giấy tờ eKYC mới'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.titleSmall(color: AppColors.textPrimaryDark),
          ),
        ),
      ],
    );
  }
}
