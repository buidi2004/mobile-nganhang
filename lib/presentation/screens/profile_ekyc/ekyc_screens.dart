import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class EKycScreen extends StatefulWidget {
  const EKycScreen({super.key});

  @override
  State<EKycScreen> createState() => _EKycScreenState();
}

class _EKycScreenState extends State<EKycScreen> {
  int _step = 1; // 1: Front ID, 2: Back ID, 3: Face Liveness, 4: Complete
  bool _isCapturing = false;

  void _nextStep() {
    setState(() => _isCapturing = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _isCapturing = false;
        _step++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: Text('Xác Thực eKYC (Bước $_step/3)'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: _step == 4 ? _buildSuccessView() : _buildStepView(),
      ),
    );
  }

  Widget _buildStepView() {
    String stepTitle = '';
    String stepInstruction = '';
    IconData stepIcon = CupertinoIcons.camera_fill;

    if (_step == 1) {
      stepTitle = 'Chụp mặt trước CCCD gắn chip';
      stepInstruction = 'Đặt mặt trước thẻ nằm trọn vẹn trong khung hình, đảm bảo rõ nét, không lóa sáng.';
      stepIcon = CupertinoIcons.creditcard_fill;
    } else if (_step == 2) {
      stepTitle = 'Chụp mặt sau CCCD gắn chip';
      stepInstruction = 'Đặt mặt sau thẻ, rõ dải mã vạch MRZ và chip vi mạch.';
      stepIcon = CupertinoIcons.creditcard;
    } else if (_step == 3) {
      stepTitle = 'Quét khuôn mặt (Face Liveness)';
      stepInstruction = 'Nhìn thẳng vào camera, giữ điện thoại ngang tầm mắt và chớp mắt nhẹ.';
      stepIcon = CupertinoIcons.person_crop_circle;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          // Step Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (idx) {
              final stepNum = idx + 1;
              final isCurrent = stepNum == _step;
              final isDone = stepNum < _step;
              return Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: isDone
                        ? AppColors.emeraldGreen
                        : (isCurrent ? AppColors.primary : AppColors.cardDark),
                    child: isDone
                        ? const Icon(CupertinoIcons.checkmark, size: 14, color: Colors.white)
                        : Text('$stepNum', style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  if (idx < 2)
                    Container(
                      width: 40,
                      height: 2,
                      color: isDone ? AppColors.emeraldGreen : AppColors.cardBorderDark,
                    ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),

          Text(stepTitle, textAlign: TextAlign.center, style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 6),
          Text(stepInstruction, textAlign: TextAlign.center, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
          const SizedBox(height: 24),

          // Camera Viewfinder Simulation
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Simulated guide frame
                  if (_step == 3)
                    Container(
                      width: 220,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(120),
                        border: Border.all(color: AppColors.emeraldGreen, width: 2.5),
                      ),
                      child: const Center(
                        child: Icon(CupertinoIcons.person_alt, size: 100, color: Colors.white24),
                      ),
                    )
                  else
                    Container(
                      width: 280,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: Center(
                        child: Icon(stepIcon, size: 64, color: Colors.white24),
                      ),
                    ),

                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _step == 3 ? 'AI Face Liveness: 99.8%' : 'AI OCR: Tự động căn chỉnh',
                        style: const TextStyle(color: AppColors.emeraldGreen, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Capture Button
          ElevatedButton.icon(
            onPressed: _isCapturing ? null : _nextStep,
            icon: _isCapturing
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Icon(CupertinoIcons.camera_fill, size: 20),
            label: Text(_isCapturing ? 'Đang xử lý hình ảnh...' : (_step == 3 ? 'Hoàn tất quét khuôn mặt' : 'Chụp ảnh & Tiếp tục')),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.emeraldGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.emeraldGreen, size: 54),
          ),
          const SizedBox(height: 24),
          Text('Xác Thực eKYC Thành Công!', style: AppTypography.displaySmall(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 12),
          Text(
            'Hệ thống đã đối soát thành công thông tin CCCD gắn chip và sinh trắc học khuôn mặt của BÙI ĐỨC VƯƠNG.\nTài khoản đã được nâng lên Cấp 2 với hạn mức 100.000.000đ/ngày.',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/profile');
              }
            },
            child: const Text('Về hồ sơ cá nhân'),
          ),
        ],
      ),
    );
  }
}
