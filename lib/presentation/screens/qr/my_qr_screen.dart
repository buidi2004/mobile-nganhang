import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class MyQRScreen extends StatefulWidget {
  const MyQRScreen({super.key});

  @override
  State<MyQRScreen> createState() => _MyQRScreenState();
}

class _MyQRScreenState extends State<MyQRScreen> {
  final String _qrData = '00020101021238580010A00000072701280006970422011409012345678953037045802VN6304';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Mã QR Của Tôi'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GlassCard(
                quality: GlassQuality.premium,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('VietQR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          const Text('• Sen Hồng Bank', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: 220,
                        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF0F172A)),
                        dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 16),
                      Text('BÙI ĐỨC VƯƠNG', style: AppTypography.titleLarge(color: Colors.black87)),
                      const Text('STK: 090123456789 (Ví Sen Hồng)', style: TextStyle(color: Colors.black54, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.arrow_down_doc_fill),
                      label: const Text('Lưu ảnh QR'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cardDark,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.share),
                      label: const Text('Chia sẻ'),
                    ),
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
