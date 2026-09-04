import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Icon 4 ô vuông bo góc đa sắc XOAY NGHIÊNG CHÉO 3D kèm ngôi sao lấp lánh (Sparkle)
/// Khớp chuẩn xác góc nghiêng ~22 độ và bề mặt nổi 3D trong ảnh mẫu tham chiếu
class FourTileQuickActionIcon extends StatelessWidget {
  final double size;

  const FourTileQuickActionIcon({
    super.key,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    final tileSize = size * 0.42;
    final borderRadius = BorderRadius.circular(tileSize * 0.38);

    return SizedBox(
      width: size + 8,
      height: size + 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hiệu ứng ánh sáng tỏa tròn (Radial Glow) phía sau cụm icon
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00E5FF).withOpacity(0.35),
                    const Color(0xFF00B4D8).withOpacity(0.15),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // Khối 4 ô vuông xoay góc 22 độ
          Transform.rotate(
            angle: 0.384, // ~22 độ
            child: SizedBox(
              width: size,
              height: size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Ô TRÊN-TRÁI: Cyan phát sáng
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFF2AF598), Color(0xFF009EFD)],
                        shadowColor: const Color(0xFF00E5FF).withOpacity(0.60),
                        hasSpecularHighlight: true,
                      ),
                      const SizedBox(width: 3),
                      // 2. Ô TRÊN-PHẢI: Royal Blue
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFF5B86E5), Color(0xFF363795)],
                        shadowColor: const Color(0xFF5B86E5).withOpacity(0.50),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 3. Ô DƯỚI-TRÁI: Vàng cam Sunburst
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFFFFB300), Color(0xFFFF6F00)],
                        shadowColor: const Color(0xFFFF9800).withOpacity(0.55),
                      ),
                      const SizedBox(width: 3),
                      // 4. Ô DƯỚI-PHẢI: Xanh lá mạ Neon Green
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFFB4EC51), Color(0xFF429321)],
                        shadowColor: const Color(0xFF7ED321).withOpacity(0.50),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Điểm sáng lóe 4 cánh lấp lánh (Sparkle Star) ở góc trên bên trái
          Positioned(
            top: 2,
            left: 2,
            child: _buildSparkle(),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle() {
    return SizedBox(
      width: 13,
      height: 13,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 12,
            height: 1.8,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          Container(
            width: 1.8,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required double size,
    required BorderRadius borderRadius,
    required List<Color> colors,
    required Color shadowColor,
    bool hasSpecularHighlight = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5,
            offset: const Offset(0, 2.5),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.35),
          width: 0.8,
        ),
      ),
      child: hasSpecularHighlight
          ? Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                  colors: [
                    Colors.white.withOpacity(0.40),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55],
                ),
              ),
            )
          : null,
    );
  }
}

/// Widget chuyên trách CHỈ vẽ nền kính mờ (Layer 1: Background)
/// Không chứa bất kỳ icon / text / nút bấm nào bên trong.
/// Áp dụng đúng chuẩn kiến trúc phân tách 2 layer độc lập (SIBLING trong Stack):
/// - Layer 1 (Nền kính): Xử lý khúc xạ quang học Snell's Law (LiquidGlass) / BackdropFilter blur,
///   kèm viền vát quang học hairline siêu mảnh và bóng tiếp xúc vi mô nhẹ nhàng.
/// - Layer 2 (Nội dung): Sibling nằm đè lên trên trong Stack, sắc nét 100%, không bị ảnh hưởng bởi filter.
class GlassNavBackground extends StatelessWidget {
  final double blurSigma;
  final double borderRadius;
  final double tintOpacity;
  final bool isOval;
  final double height;
  final double? width;
  final bool useBackdropFilter;

  const GlassNavBackground({
    super.key,
    this.blurSigma = 24,
    this.borderRadius = 33,
    this.tintOpacity = 0.12,
    this.isOval = false,
    this.height = 66,
    this.width,
    this.useBackdropFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useBackdropFilter) {
      // Widget này CHỈ vẽ nền kính mờ - không chứa icon/text/nút bên trong
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(tintOpacity),
              borderRadius: isOval ? null : BorderRadius.circular(borderRadius),
              shape: isOval ? BoxShape.circle : BoxShape.rectangle,
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 0.8,
              ),
            ),
          ),
        ),
      );
    }

    // Mặc định: Nền kính quang học LiquidGlass (Snell's Law) + Viền vát siêu mảnh Hairline Rim (~0.8px)
    return _DarkBevelGlassWrapper(
      borderRadius: borderRadius,
      isOval: isOval,
      child: GlassContainer(
        width: width,
        height: height,
        useOwnLayer: true,
        quality: GlassQuality.premium,
        shape: isOval
            ? const LiquidOval()
            : LiquidRoundedRectangle(borderRadius: borderRadius),
        settings: const LiquidGlassSettings(
          thickness: 22,
          blur: 4.0,
          glassColor: Color(0x14FFFFFF),
          lightIntensity: 0.75,
          refractiveIndex: 1.22,
          chromaticAberration: 0.03,
          ambientStrength: 0.16,
          fresnelStrength: 0.95,
          saturation: 1.20,
          edgeAbsorption: 0.06,
          shadowElevation: 0.0,
        ),
      ),
    );
  }
}

/// Thanh điều hướng nổi sử dụng kiến trúc 2 Layer Sibling trong Stack:
/// - Layer 1: [GlassNavBackground] CHỈ vẽ nền kính mờ và viền vát quang học (không chứa nội dung)
/// - Layer 2: Nội dung (4 tab icons, active cyan pill, 3D quick action button) nằm ĐÈ LÊN TRÊN, sắc nét 100%
class FloatingGlassBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onQuickActionPressed;

  const FloatingGlassBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onQuickActionPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(88);

  static const List<IconData> _tabIconsLinear = [
    Iconsax.home_2,
    Iconsax.receipt_item,
    Iconsax.notification,
    Iconsax.profile_circle,
  ];

  static const List<IconData> _tabIconsBold = [
    Iconsax.home_2_copy,
    Iconsax.receipt_item_copy,
    Iconsax.notification_copy,
    Iconsax.profile_circle_copy,
  ];

  @override
  Widget build(BuildContext context) {
    return GlassAdaptiveScope(
      minQuality: GlassQuality.premium,
      maxQuality: GlassQuality.premium,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              // ĐẢO BÊN TRÁI: Thanh capsule kính chứa 4 tabs
              // Ghép 2 layer SIBLING trong Stack: Nền riêng, Nội dung riêng
              Expanded(
                child: SizedBox(
                  height: 66,
                  child: Stack(
                    children: [
                      // Layer 1: NỀN kính mờ - CHỈ có blur + refraction + tint + hairline rim, không chứa gì khác
                      const Positioned.fill(
                        child: GlassNavBackground(
                          borderRadius: 33,
                          height: 66,
                        ),
                      ),

                      // Layer 2: NỘI DUNG - icon/text/active pill nằm ĐÈ LÊN TRÊN, sắc nét 100%
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: List.generate(_tabIconsLinear.length, (index) {
                              final isSelected = selectedIndex == index;
                              return Expanded(
                                child: _buildTabItem(
                                  icon: isSelected ? _tabIconsBold[index] : _tabIconsLinear[index],
                                  isSelected: isSelected,
                                  onTap: () => onTabSelected(index),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ĐẢO BÊN PHẢI: Nút tròn tiện ích nhanh
              // Ghép 2 layer SIBLING trong Stack: Nền riêng, Nội dung riêng
              SizedBox(
                width: 66,
                height: 66,
                child: Stack(
                  children: [
                    // Layer 1: NỀN kính mờ tròn - CHỈ có blur + refraction + tint + hairline rim, không chứa gì khác
                    const Positioned.fill(
                      child: GlassNavBackground(
                        isOval: true,
                        borderRadius: 33,
                        width: 66,
                        height: 66,
                      ),
                    ),

                    // Layer 2: NỘI DUNG - nút bấm tiện ích 4 ô vuông xoay 3D nằm ĐÈ LÊN TRÊN, sắc nét 100%
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onQuickActionPressed,
                          borderRadius: BorderRadius.circular(33),
                          child: const Center(
                            child: FourTileQuickActionIcon(size: 30),
                          ),
                        ),
                      ),
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

  Widget _buildTabItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOutCubic,
          // Kích thước viên thuốc nhỏ gọn, cân đối, để lại khoảng thở 12px trên dưới
          width: isSelected ? 54 : 44,
          height: 42,
          decoration: isSelected
              ? BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF26E5DC),
                      Color(0xFF00B4D8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withOpacity(0.40),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                )
              : null,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 22,
            color: isSelected ? Colors.white : const Color(0xFF2D3748),
          ),
        ),
      ),
    );
  }
}

/// Khung viền ngoài màu đen vát quang học (Dark Bevel Chamfer Frame)
/// Mô phỏng chuẩn xác viền đen cắt vát quanh khối kính trong ảnh mẫu:
/// - Đổ bóng nhẹ thanh thoát (Ambient Contact Shadow)
/// - Viền vát quang học thanh mảnh siêu sắc nét (Hairline Bevel Rim ~0.8px)
/// - Đường bắt sáng specular màu trắng ở góc trên-trái
/// - Đường viền xám khói/than tinh tế ở góc dưới-phải (không bị đen dày thô)
/// - Giữ nguyên 100% tất cả các thành phần bên trong (icons, active pill cyan, 4 ô vuông)
class _DarkBevelGlassWrapper extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final bool isOval;

  const _DarkBevelGlassWrapper({
    required this.child,
    this.borderRadius = 33,
    this.isOval = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isOval ? null : BorderRadius.circular(borderRadius),
        shape: isOval ? BoxShape.circle : BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // 1. Giữ nguyên 100% nội dung glass và bên trong không thay đổi
          child,

          // 2. Viền vát quang học thanh mảnh siêu sắc nét (Hairline Bevel Rim ~0.8px)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _DarkGlassBevelRimPainter(
                  borderRadius: borderRadius,
                  isOval: isOval,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DarkGlassBevelRimPainter extends CustomPainter {
  final double borderRadius;
  final bool isOval;

  const _DarkGlassBevelRimPainter({
    required this.borderRadius,
    required this.isOval,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Viền vát quang học thanh mảnh siêu sắc nét (~0.8px) chuẩn phong cách kính Apple
    // Tinh giản tối đa: mép trên bắt sáng specular ánh trắng bạc, mép dưới chuyển khói than nhẹ nhàng
    final rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xB0FFFFFF), // Specular highlight trắng ánh kim sắc nét mép trên-trái
          Color(0x35FFFFFF), // Ánh kính chuyển tiếp
          Color(0x2564748B), // Slate xám thanh mảnh hông
          Color(0x481E293B), // Xám than thanh nhã mép dưới (siêu mảnh, không bị đen dày)
        ],
        stops: [0.0, 0.20, 0.55, 1.0],
      ).createShader(rect);

    if (isOval) {
      canvas.drawOval(rect.deflate(0.4), rimPaint);
    } else {
      final outerRRect = RRect.fromRectAndRadius(
        rect.deflate(0.4),
        Radius.circular(borderRadius - 0.4),
      );
      canvas.drawRRect(outerRRect, rimPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DarkGlassBevelRimPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius || oldDelegate.isOval != isOval;
}

