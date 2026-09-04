import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Header Lễ hội SenBank: Tòa nhà hội sở SenBank, hoa sen vàng, cờ đỏ sao vàng.
/// Không có xe cộ, hòa quyện quang học vào ảnh nền hoa văn (glass_background_pattern).
class VietnamHeroHeader extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onSavingsTap;
  final VoidCallback? onCardsTap;

  const VietnamHeroHeader({
    super.key,
    this.onSearchTap,
    this.onSavingsTap,
    this.onCardsTap,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bannerHeight = 230.0 + topPadding;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. KHU VỰC BANNER ĐỎ SENBANK & ĐIỂM GIAO THOA QUANG HỌC VỚI ẢNH NỀN
        SizedBox(
          height: bannerHeight + 26,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ẢNH NỀN BANNER ĐỎ TÒA NHÀ SENBANK TRẢI DÀI LÊN STATUS BAR VÀ FADE OUT Ở ĐÁY
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: bannerHeight,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Color(0xEE000000),
                        Color(0x77000000),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.58, 0.78, 0.90, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/senbank_hero_banner.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),

              // VỆT SÁNG MỜ DỊU NHẸ Ở ĐIỂM GIAO THOA (MIST GLOW)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                height: 55,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // THANH TÌM KIẾM DỊCH VỤ SENBANK GỐI NỬA LÊN BANNER VÀ NỬA LÊN ẢNH NỀN
              Positioned(
                left: 16,
                right: 16,
                bottom: 0,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(27),
                      onTap: onSearchTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.search,
                              size: 22,
                              color: Color(0xFF334155),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Tìm kiếm dịch vụ, chuyển tiền, tiết kiệm...',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // 2. HAI THẺ THAO TÁC ĐẦU TIÊN CỦA SENBANK: "GỬI TIẾT KIỆM" & "MỞ THẺ SENBANK"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Thẻ Gửi tiết kiệm
              Expanded(
                child: _buildServiceCard(
                  title: 'Gửi tiết kiệm',
                  subtitle: 'Lãi suất 7.2%/năm',
                  imagePath: 'assets/images/banking_savings.png',
                  imageHeight: 68,
                  imageBottom: 4,
                  imageRight: 4,
                  onTap: onSavingsTap,
                ),
              ),
              const SizedBox(width: 12),
              // Thẻ Mở thẻ SenBank
              Expanded(
                child: _buildServiceCard(
                  title: 'Mở thẻ SenBank',
                  subtitle: 'Ưu đãi hoàn 15%',
                  imagePath: 'assets/images/banking_card.png',
                  imageHeight: 68,
                  imageBottom: 4,
                  imageRight: 4,
                  onTap: onCardsTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required double imageHeight,
    required double imageBottom,
    required double imageRight,
    required VoidCallback? onTap,
  }) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.95),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Stack(
            children: [
              // Tiêu đề & phụ đề dịch vụ ở góc trên trái
              Positioned(
                top: 12,
                left: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE11D48), // Rose gold accent
                      ),
                    ),
                  ],
                ),
              ),
              // Hình ảnh 3D ở góc dưới phải
              Positioned(
                bottom: imageBottom,
                right: imageRight,
                child: Image.asset(
                  imagePath,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
