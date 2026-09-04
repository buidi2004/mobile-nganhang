import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Điều Khoản Dịch Vụ'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ĐIỀU KHOẢN & ĐIỀU KIỆN SỬ DỤNG VÍ ĐIỆN TỬ SEN HỒNG', style: AppTypography.titleLarge(color: AppColors.primaryLight)),
                        const SizedBox(height: 8),
                        Text('Cập nhật lần cuối: 01/01/2026', style: AppTypography.bodySmall(color: AppColors.textMutedDark)),
                        const Divider(height: 24, color: AppColors.cardBorderDark),
                        _buildSection(
                          '1. Quy định chung',
                          'Bằng việc tải, cài đặt và sử dụng ứng dụng Ví điện tử Sen Hồng, khách hàng đồng ý chịu sự ràng buộc bởi các Điều khoản và Điều kiện này cũng như các quy định pháp luật hiện hành của Ngân hàng Nhà nước Việt Nam về cung ứng dịch vụ trung gian thanh toán.',
                        ),
                        _buildSection(
                          '2. Bảo vệ dữ liệu cá nhân (Nghị định 13/2023/NĐ-CP)',
                          'Sen Hồng cam kết bảo mật tuyệt đối thông tin dữ liệu cá nhân, thông tin sinh trắc học và lịch sử giao dịch của khách hàng. Dữ liệu chỉ được xử lý phục vụ định danh khách hàng eKYC, phòng chống rửa tiền và xác thực giao dịch tài chính an toàn.',
                        ),
                        _buildSection(
                          '3. Xác thực giao dịch và Hạn mức thanh toán',
                          'Khách hàng có trách nhiệm bảo mật Mã đăng nhập, Mật khẩu, Mã PIN giao dịch 6 số và OTP. Mọi lệnh chuyển tiền được ký bằng PIN hoặc Smart OTP hợp lệ đều được coi là ý chí của chủ tài khoản.',
                        ),
                        _buildSection(
                          '4. Phí dịch vụ và Hoàn tiền',
                          'Các giao dịch chuyển tiền nội bộ giữa các ví Sen Hồng hoàn toàn miễn phí. Đối với giao dịch chuyển liên ngân hàng Napas 24/7, biểu phí được công khai minh bạch trước khi xác nhận lệnh chuyển.',
                        ),
                        _buildSection(
                          '5. Quyền và nghĩa vụ của khách hàng',
                          'Khách hàng cam kết cung cấp thông tin CCCD chính chủ, không cho thuê, mượn hoặc sử dụng ví vào các mục đích vi phạm pháp luật (cờ bạc, gian lận, rửa tiền).',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/');
                  }
                },
                child: const Text('Tôi đã đọc và đồng ý'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 4),
          Text(content, style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
        ],
      ),
    );
  }
}
