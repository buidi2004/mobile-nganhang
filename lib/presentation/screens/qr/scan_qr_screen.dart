import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isTorchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final code = barcode.rawValue!;
        // Điều hướng sang xác nhận chuyển tiền với mã quét được
        context.push('/transfer/amount?recipient=$code');
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera View
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // QR Scanner Overlay
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Action Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/');
                          }
                        },
                        icon: const Icon(CupertinoIcons.clear_circled_solid, color: Colors.white, size: 32),
                      ),
                      Text(
                        'Quét mã VietQR',
                        style: AppTypography.titleLarge(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller.toggleTorch();
                          setState(() => _isTorchOn = !_isTorchOn);
                        },
                        icon: Icon(
                          _isTorchOn ? CupertinoIcons.bolt_fill : CupertinoIcons.bolt_slash_fill,
                          color: _isTorchOn ? AppColors.accentGold : Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Target Box
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.bottomBarCyan, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bottomBarGlow.withOpacity(0.40),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: AppColors.bottomBarCyan,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.bottomBarGlow,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Tools (Glass Controls)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                  child: GlassCard(
                    quality: GlassQuality.minimal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildToolItem(
                            icon: CupertinoIcons.photo_fill,
                            label: 'Chọn ảnh',
                            onTap: () {},
                          ),
                          _buildToolItem(
                            icon: CupertinoIcons.qrcode,
                            label: 'Mã QR của tôi',
                            onTap: () => context.push('/my-qr'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
