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
            Expanded(
              child: GlassContainer(
                height: 66,
                useOwnLayer: true,
                quality: GlassQuality.premium,
                shape: const LiquidRoundedSuperellipse(borderRadius: 33),
                settings: const LiquidGlassSettings(
                  thickness: 35,
                  blur: 6,
                  glassColor: Color(0x15FFFFFF),
                  lightIntensity: 0.70,
                  refractiveIndex: 1.36,
                  chromaticAberration: 0.04,
                  ambientStrength: 0.12,
                  fresnelStrength: 1.2,
                  saturation: 1.3,
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

            const SizedBox(width: 12),

            // ĐẢO BÊN PHẢI: Nút tròn tiện ích nhanh bằng GlassContainer (LiquidOval)
            GlassContainer(
              width: 66,
              height: 66,
              useOwnLayer: true,
              quality: GlassQuality.premium,
              shape: const LiquidOval(),
              settings: const LiquidGlassSettings(
                thickness: 35,
                blur: 6,
                glassColor: Color(0x18FFFFFF),
                lightIntensity: 0.75,
                refractiveIndex: 1.36,
                chromaticAberration: 0.04,
                ambientStrength: 0.12,
                fresnelStrength: 1.2,
                saturation: 1.3,
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
