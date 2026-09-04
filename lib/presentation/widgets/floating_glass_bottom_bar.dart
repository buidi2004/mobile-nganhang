import 'dart:math' as math;
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
    return Padding(
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
                  shape: const LiquidRoundedSuperellipse(borderRadius: 33),
                  settings: const LiquidGlassSettings(
                    thickness: 42,
                    blur: 5,
                    glassColor: Color(0x14FFFFFF),
                    lightIntensity: 0.75,
                    refractiveIndex: 1.52,
                    chromaticAberration: 0.06,
                    ambientStrength: 0.15,
                    fresnelStrength: 1.25,
                    saturation: 1.3,
                    edgeAbsorption: 0.35,
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
                  thickness: 42,
                  blur: 5,
                  glassColor: Color(0x16FFFFFF),
                  lightIntensity: 0.78,
                  refractiveIndex: 1.52,
                  chromaticAberration: 0.06,
                  ambientStrength: 0.15,
                  fresnelStrength: 1.25,
                  saturation: 1.3,
                  edgeAbsorption: 0.35,
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
/// - Đổ bóng nổi không gian 3D (Ambient Drop Shadow)
/// - Dải viền đen/khói vát quang học (Dark Meniscus Chamfer Band) dày ~3.2px
/// - Đường bắt sáng specular màu trắng ở góc trên-trái
/// - Đường bóng đổ đậm ở góc dưới-phải
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
            color: Colors.black.withOpacity(0.38),
            blurRadius: 18,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
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

          // 2. Viền đen ngoài vát quang học (Dark Glass Chamfer Rim) chuẩn xác như ảnh mẫu
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

    // 1. Viền ngoài cùng mảnh (Hairline Outer Rim) với hiệu ứng bắt sáng từ góc trên-trái
    // và bóng đổ sâu ở góc dưới-phải
    final outerStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0x95FFFFFF), // Bắt sáng specular màu trắng ở mép trên-trái
          Color(0x80334155), // Chuyển tiếp ghi xám / dark slate
          Color(0xCC0F172A), // Ghi than tối
          Color(0xF0000000), // Mép dưới bóng đổ đen tuyền
        ],
        stops: [0.0, 0.25, 0.65, 1.0],
      ).createShader(rect);

    // 2. Dải viền vát quang học màu đen/khói (Dark Glass Bevel Chamfer Band) dày ~3.2px
    // Đây chính là dải viền đen đặc trưng quanh viền kính như trong ảnh mẫu
    final bevelBandRect = Rect.fromLTWH(1.5, 1.5, size.width - 3.0, size.height - 3.0);
    final bevelBandRadius = math.max(0.0, borderRadius - 1.5);
    final bevelPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x55334155), // Phần trên mờ nhẹ
          Color(0x771E293B), // Phần thân viền tối
          Color(0xC80A0E17), // Phần dưới viền đen đậm
        ],
        stops: [0.0, 0.40, 1.0],
      ).createShader(rect);

    // 3. Đường rãnh giáp ranh bên trong (Inner Transition Groove)
    // Tách biệt giữa dải viền đen và mặt kính trong suốt ở trung tâm
    final innerGrooveRect = Rect.fromLTWH(3.2, 3.2, size.width - 6.4, size.height - 6.4);
    final innerGrooveRadius = math.max(0.0, borderRadius - 3.2);
    final innerGroovePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x20FFFFFF), // Mép trên kính sáng nhẹ
          Color(0x40000000), // Mép dưới kính tối
        ],
      ).createShader(rect);

    if (isOval) {
      canvas.drawOval(rect.deflate(0.7), outerStrokePaint);
      canvas.drawOval(bevelBandRect, bevelPaint);
      canvas.drawOval(innerGrooveRect, innerGroovePaint);
    } else {
      final outerRRect = RRect.fromRectAndRadius(
        rect.deflate(0.7),
        Radius.circular(borderRadius - 0.7),
      );
      final bevelRRect = RRect.fromRectAndRadius(
        bevelBandRect,
        Radius.circular(bevelBandRadius),
      );
      final innerRRect = RRect.fromRectAndRadius(
        innerGrooveRect,
        Radius.circular(innerGrooveRadius),
      );

      canvas.drawRRect(outerRRect, outerStrokePaint);
      canvas.drawRRect(bevelRRect, bevelPaint);
      canvas.drawRRect(innerRRect, innerGroovePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DarkGlassBevelRimPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius || oldDelegate.isOval != isOval;
}

