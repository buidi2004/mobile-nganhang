import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Banner quảng cáo gói tiết kiệm có góc bo cong nghệ thuật ("Bẻ cong ảnh dưới" & "Ghép ảnh chéo")
/// khớp với thiết kế trong ảnh mẫu tham chiếu
class CurvedPromoBanner extends StatelessWidget {
  final VoidCallback? onRegisterTap;
  final bool isDiagonalSlanted;

  const CurvedPromoBanner({
    super.key,
    this.onRegisterTap,
    this.isDiagonalSlanted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isDiagonalSlanted) {
      return _buildDiagonalSlantedBanner(context);
    }
    return _buildStandardBanner(context);
  }

  Widget _buildStandardBanner(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF005C8A),
              Color(0xFF0083B0),
              Color(0xFF00B4DB),
              Color(0xFF48CAE4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0083B0).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Lớp đồ họa lượn sóng bo cong nghệ thuật ở nền dưới ("bẻ cong ảnh dưới")
            Positioned.fill(
              child: CustomPaint(
                painter: _CurvedWaveBackgroundPainter(),
              ),
            ),


            // Các hạt lấp lánh & vòng tròn trang trí
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFD54F).withOpacity(0.15),
                ),
              ),
            ),

            // Nội dung chính
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tag huy hiệu
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 0.8,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bolt, color: Color(0xFFFFD54F), size: 14),
                              SizedBox(width: 4),
                              Text(
                                'ƯU ĐÃI ĐẶC QUYỀN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Tiêu đề: GÓI TIẾT KIỆM (chữ trắng 3D)
                        Text(
                          'GÓI TIẾT KIỆM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.35),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        // Dòng phụ: 100K ƯU ĐÃI (màu vàng rực rỡ nổi 3D)
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB300),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                '100K',
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'ƯU ĐÃI',
                              style: TextStyle(
                                color: Color(0xFFFFEB3B),
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Nút ĐĂNG KÝ NGAY
                        InkWell(
                          onTap: onRegisterTap,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ĐĂNG KÝ NGAY',
                                  style: TextStyle(
                                    color: Color(0xFF0077B6),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  CupertinoIcons.arrow_right,
                                  size: 12,
                                  color: Color(0xFF0077B6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Đồ họa icon 3D bên phải
                  Expanded(
                    flex: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Hào quang tỏa sáng
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                        // Biểu tượng heo tiết kiệm / tiền vàng
                        Container(
                          width: 74,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.money_dollar_circle_fill,
                            size: 46,
                            color: Color(0xFFFFD54F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bố cục Ghép ảnh chéo (Diagonal Slanted Composite Banner)
  /// Khớp chính xác góc nghiêng, dải màu teal-yellow và ảnh ghép chéo trong ảnh mẫu tham chiếu
  Widget _buildDiagonalSlantedBanner(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 195,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF005F73),
              Color(0xFF0A9396),
              Color(0xFF0096C7),
              Color(0xFF48CAE4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A9396).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 1. Dải sóng chéo nền (Diagonal Wave Streaks)
            Positioned.fill(
              child: CustomPaint(
                painter: _DiagonalWaveBackgroundPainter(),
              ),
            ),

            // 2. ẢNH GHÉP CHÉO BÊN PHẢI (Diagonal Photo Card)
            // Khung ảnh bo cong nghiêng chéo góc -10 độ thể hiện du lịch/tận hưởng cuộc sống
            Positioned(
              right: -15,
              top: -10,
              bottom: -15,
              child: Transform.rotate(
                angle: -0.16, // Nghiêng chéo ~9.5 độ
                child: Container(
                  width: 155,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE0F7FA),
                        Color(0xFF80DEEA),
                        Color(0xFF00ACC1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 16,
                        offset: const Offset(-3, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Vòng cung mặt nước / bầu trời
                      Positioned(
                        top: 20,
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.35),
                          ),
                        ),
                      ),
                      // Icon du lịch / thuyền buồm / trải nghiệm
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.compass_fill,
                            size: 44,
                            color: const Color(0xFF0077B6).withOpacity(0.90),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'DU LỊCH HÈ',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0077B6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. NỘI DUNG CHÉO BÊN TRÁI (Slanted Typography & Yellow 100K Badge)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 140, 16),
              child: Transform.rotate(
                angle: -0.06, // Nghiêng nhẹ đồng điệu theo ảnh mẫu
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Badge nhỏ trên đỉnh
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.35),
                          width: 0.8,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt, color: Color(0xFFFFD54F), size: 13),
                          SizedBox(width: 3),
                          Text(
                            'ƯU ĐÃI ĐẶC QUYỀN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Tiêu đề: GÓI TIẾT KIỆM (chữ trắng 3D nghiêng chéo)
                    Text(
                      'GÓI TIẾT KIỆM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.6,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.40),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Dòng huy hiệu vàng: 100K ƯU ĐÃI (nổi bật rực rỡ)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            '100K',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'ƯU ĐÃI',
                          style: TextStyle(
                            color: Color(0xFFFFEB3B),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Nút ĐĂNG KÝ NGAY
                    InkWell(
                      onTap: onRegisterTap,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ĐĂNG KÝ NGAY',
                              style: TextStyle(
                                color: Color(0xFF0077B6),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 12,
                              color: Color(0xFF0077B6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// CustomPainter vẽ đường cong sóng biển uốn lượn ở góc dưới của banner ("bẻ cong ảnh dưới")
class _CurvedWaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Sóng phụ mờ 1
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.45);
    path1.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.2,
      size.width * 0.7,
      size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.88,
      size.height * 0.65,
      size.width,
      size.height * 0.4,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Sóng chính uốn cong đáy 2
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.65);
    path2.cubicTo(
      size.width * 0.3,
      size.height * 0.45,
      size.width * 0.6,
      size.height * 0.85,
      size.width,
      size.height * 0.6,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// CustomPainter vẽ các dải sóng và vệt sáng chéo cho banner ghép ảnh chéo
class _DiagonalWaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dải sóng chéo ngọc lam đậm
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.09)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.3);
    path1.lineTo(size.width * 0.85, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.7);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // 2. Vệt sáng chéo trắng mờ
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.14)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(size.width * 0.25, size.height);
    path2.lineTo(size.width * 0.95, size.height * 0.25);
    path2.lineTo(size.width, size.height * 0.35);
    path2.lineTo(size.width * 0.45, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // 3. Vòng tròn trang trí góc trái đáy
    final circlePaint = Paint()
      ..color = const Color(0xFFFFD54F).withOpacity(0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.85), 55, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

