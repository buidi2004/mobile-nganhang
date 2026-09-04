import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/presentation/widgets/custom_pin_numpad.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String _pin = '';
  String? _firstPin;
  bool _isConfirm = false;

  void _onPinChanged(String value) {
    setState(() => _pin = value);
    if (value.length == 6) {
      if (!_isConfirm) {
        // Chuyển sang bước nhập lại PIN
        setState(() {
          _firstPin = value;
          _pin = '';
          _isConfirm = true;
        });
      } else {
        if (_pin == _firstPin) {
          // Thành công -> Vào Trang Chủ
          context.go('/');
        } else {
          // Không khớp -> Làm lại
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mã PIN không khớp, vui lòng thử lại')),
          );
          setState(() {
            _pin = '';
            _firstPin = null;
            _isConfirm = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Thiết Lập Mã PIN')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              _isConfirm ? 'Xác nhận lại mã PIN' : 'Tạo mã PIN giao dịch',
              style: AppTypography.displaySmall(color: AppColors.textPrimaryDark),
            ),
            const SizedBox(height: 8),
            Text(
              _isConfirm
                  ? 'Nhập lại 6 chữ số vừa tạo để hoàn tất'
                  : 'Mã PIN gồm 6 số dùng để xác thực mọi giao dịch chuyển tiền',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark),
            ),
            const Spacer(),
            CustomPinNumpad(
              pin: _pin,
              maxDigits: 6,
              onPinChanged: _onPinChanged,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
