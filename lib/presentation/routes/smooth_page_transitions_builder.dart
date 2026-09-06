import 'package:flutter/material.dart';

/// Bộ chuyển trang cao cấp chuẩn Ngân Hàng Số (Fintech Smooth Transition):
/// - Hiệu ứng trượt nhẹ định hướng (25% Slide Offset) kết hợp mờ dần (Subtle Fade)
/// - Hiệu ứng thị sai (Parallax Depth): Màn hình phía dưới trượt nhẹ -8% và mờ nhẹ
/// - Đường cong chuyển động Cubic(0.16, 1.0, 0.3, 1.0) chuẩn iOS & Fintech thế hệ mới
/// - Tương thích 100% trên mọi nền tảng (iOS, Android, Windows, macOS, Web)
class SmoothFintechPageTransitionsBuilder extends PageTransitionsBuilder {
  const SmoothFintechPageTransitionsBuilder();

  // Đường cong chuyển động êm ái tự nhiên (Fintech Fluid Deceleration Curve)
  static const Curve _smoothCurve = Cubic(0.16, 1.0, 0.3, 1.0);

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Đường cong gia tốc vào mượt mà
    final primaryCurve = CurvedAnimation(
      parent: animation,
      curve: _smoothCurve,
      reverseCurve: Curves.easeInCubic,
    );

    // Đường cong cho màn hình bị che khuất (thị sai phía dưới)
    final secondaryCurve = CurvedAnimation(
      parent: secondaryAnimation,
      curve: _smoothCurve,
      reverseCurve: Curves.easeInCubic,
    );

    // 1. Màn hình mới tiến vào: Trượt từ phải 25% + Fade in từ 0 đến 1
    final slideIn = Tween<Offset>(
      begin: const Offset(0.25, 0.0),
      end: Offset.zero,
    ).animate(primaryCurve);

    final fadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      reverseCurve: const Interval(0.35, 1.0, curve: Curves.easeIn),
    ));

    // 2. Màn hình cũ bị che: Trượt thị sai lùi -8% + Mờ nhẹ xuống 88%
    final parallaxSlideOut = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.08, 0.0),
    ).animate(secondaryCurve);

    final parallaxFadeOut = Tween<double>(
      begin: 1.0,
      end: 0.88,
    ).animate(secondaryCurve);

    return SlideTransition(
      position: parallaxSlideOut,
      child: FadeTransition(
        opacity: parallaxFadeOut,
        child: SlideTransition(
          position: slideIn,
          child: FadeTransition(
            opacity: fadeIn,
            child: child,
          ),
        ),
      ),
    );
  }
}
