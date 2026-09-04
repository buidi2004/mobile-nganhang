import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'core/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-warm fragment shader để tránh hiện tượng nháy trắng (warmup jank) lần đầu
  await LiquidGlassWidgets.initialize();

  runApp(
    LiquidGlassWidgets.wrap(
      brightnessResolver: Theme.maybeBrightnessOf,
      adaptiveQuality: true, // Tự động benchmark thiết bị và hạ quality khi máy yếu/nóng
      theme: AppTheme.glassTheme,
      child: const SenHongApp(),
    ),
  );
}

class SenHongApp extends StatelessWidget {
  const SenHongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sen Hồng Bank',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        // Đảm bảo Material transparency ancestor cho liquid_glass_widgets
        return Material(
          type: MaterialType.transparency,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
