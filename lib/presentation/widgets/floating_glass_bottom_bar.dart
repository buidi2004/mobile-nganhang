import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          // 4 ô vuông bo góc xếp 2x2 xoay nghiêng chéo 22 độ (Diagonal Orientation)
          Transform.rotate(
            angle: 0.38, // Góc xoay nghiêng chéo ~22 độ như ảnh mẫu
            child: SizedBox(
              width: size,
              height: size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top-Left: Cyan / Light Blue bóng 3D
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFF00E5FF), Color(0xFF00B4D8)],
                        glowColor: const Color(0xFF00E5FF),
                      ),
                      const SizedBox(width: 3.5),
                      // Top-Right: Royal Blue / Indigo bóng 3D
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFF2979FF), Color(0xFF1D4ED8)],
                        glowColor: const Color(0xFF2979FF),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bottom-Left: Golden Amber / Orange bóng 3D
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFFFFB300), Color(0xFFFF6D00)],
                        glowColor: const Color(0xFFFF9100),
                      ),
                      const SizedBox(width: 3.5),
                      // Bottom-Right: Lime Green bóng 3D
                      _buildTile(
                        size: tileSize,
                        borderRadius: borderRadius,
                        colors: const [Color(0xFF00E676), Color(0xFF00C853)],
                        glowColor: const Color(0xFF00E676),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Ngôi sao lấp lánh (Sparkle 4-point star) ở góc trên bên trái
          Positioned(
            left: 0,
            top: 0,
            child: Icon(
              Icons.auto_awesome,
              size: size * 0.42,
              color: Colors.white,
              shadows: const [
                Shadow(
                  color: Colors.white,
                  blurRadius: 8,
                ),
                Shadow(
                  color: Color(0xFF00E5FF),
                  blurRadius: 5,
                ),
              ],
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
    required Color glowColor,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.50),
            blurRadius: 6,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.40),
              Colors.transparent,
            ],
            stops: const [0.0, 0.55],
          ),
        ),
      ),
    );
  }
}

/// Thanh điều hướng nổi sử dụng [GlassContainer] chính thức từ thư viện `liquid_glass_widgets`
/// Thiết kế 2 đảo kính (Dual Island) với viên thuốc active Cyan nhỏ gọn, tinh tế, vừa vặn
/// tỷ lệ thẩm mỹ (không bị bè to hay chạm sát viền trên dưới).
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

  static const List<IconData> _tabIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.clock_fill,
    CupertinoIcons.bell_fill,
    CupertinoIcons.person_fill,
  ];

  @override
  Widget build(BuildContext context) {
    // Ép cứng chất lượng GlassQuality.premium bằng GlassAdaptiveScope
    // Ngăn chặn 100% bug benchmark tự động hạ cấp xuống standard sau vài giây đầu
    return GlassAdaptiveScope(
      minQuality: GlassQuality.premium,
      maxQuality: GlassQuality.premium,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: SizedBox(
          height: 66,
          child: Row(
            children: [
              // ĐẢO BÊN TRÁI: Thanh capsule kính chứa 4 tabs bằng GlassContainer chính thức
              // bọc trong khung viền đen vát quang học (Dark Glass Bevel Rim)
              Expanded(
                child: _DarkBevelGlassWrapper(
                  borderRadius: 33,
                  child: GlassContainer(
                    height: 66,
                    useOwnLayer: true,
                    quality: GlassQuality.premium,
                    shape: const LiquidRoundedRectangle(borderRadius: 33),
                    settings: const LiquidGlassSettings(
                      thickness: 48,
                      blur: 4.5,
                      glassColor: Color(0x14FFFFFF),
                      lightIntensity: 0.78,
                      refractiveIndex: 1.58,
                      chromaticAberration: 0.08,
                      ambientStrength: 0.16,
                      fresnelStrength: 1.30,
                      saturation: 1.35,
                      edgeAbsorption: 0.12,
                      shadowElevation: 0.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: List.generate(_tabIcons.length, (index) {
                          final isSelected = selectedIndex == index;
                          return Expanded(
                            child: _buildTabItem(
                              icon: _tabIcons[index],
                              isSelected: isSelected,
                              onTap: () => onTabSelected(index),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ĐẢO BÊN PHẢI: Nút tròn tiện ích nhanh bằng GlassContainer (LiquidOval)
              // bọc trong khung viền đen vát quang học (Dark Glass Bevel Rim)
              _DarkBevelGlassWrapper(
                isOval: true,
                borderRadius: 33,
                child: GlassContainer(
                  width: 66,
                  height: 66,
                  useOwnLayer: true,
                  quality: GlassQuality.premium,
                  shape: const LiquidOval(),
                  settings: const LiquidGlassSettings(
                    thickness: 48,
                    blur: 4.5,
                    glassColor: Color(0x16FFFFFF),
                    lightIntensity: 0.80,
                    refractiveIndex: 1.58,
                    chromaticAberration: 0.08,
                    ambientStrength: 0.16,
                    fresnelStrength: 1.30,
                    saturation: 1.35,
                    edgeAbsorption: 0.12,
                    shadowElevation: 0.0,
                  ),
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

