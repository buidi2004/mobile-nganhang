import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({super.key});

  @override
  State<DeviceManagementScreen> createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  final List<Map<String, dynamic>> _devices = [
    {
      'id': 'd1',
      'model': 'iPhone 15 Pro Max (Thiết bị này)',
      'os': 'iOS 18.2 • Sen Hồng App v1.0.0',
      'ip': '14.241.120.88 (Hà Nội, VN)',
      'lastActive': 'Đang hoạt động',
      'isCurrent': true,
    },
    {
      'id': 'd2',
      'model': 'Samsung Galaxy S24 Ultra',
      'os': 'Android 14 • Chrome Browser',
      'ip': '113.161.42.15 (TP.HCM, VN)',
      'lastActive': '03/09/2026 - 15:42',
      'isCurrent': false,
    },
    {
      'id': 'd3',
      'model': 'MacBook Pro M3 Max',
      'os': 'macOS Sequoia • Safari Web',
      'ip': '14.241.120.88 (Hà Nội, VN)',
      'lastActive': '28/08/2026 - 09:15',
      'isCurrent': false,
    },
  ];

  void _logoutDevice(String id) {
    setState(() => _devices.removeWhere((d) => d['id'] == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Đã đăng xuất phiên thiết bị thành công!'),
      ),
    );
  }

  void _logoutAllOtherDevices() {
    setState(() => _devices.removeWhere((d) => !d['isCurrent']));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Đã đăng xuất khỏi tất cả các thiết bị khác!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Quản Lý Thiết Bị'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Phiên đăng nhập đang hoạt động', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 6),
            Text('Kiểm tra các thiết bị có quyền truy cập tài khoản của bạn. Đăng xuất ngay nếu phát hiện thiết bị lạ.', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 16),

            ..._devices.map((d) {
              final isCurrent = d['isCurrent'] as bool;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCurrent ? CupertinoIcons.device_phone_portrait : CupertinoIcons.device_laptop,
                              color: isCurrent ? AppColors.emeraldGreen : AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                d['model'] as String,
                                style: AppTypography.titleMedium(
                                  color: isCurrent ? AppColors.emeraldGreen : AppColors.textPrimaryDark,
                                ),
                              ),
                            ),
                            if (!isCurrent)
                              IconButton(
                                icon: const Icon(CupertinoIcons.square_arrow_right, color: AppColors.error, size: 20),
                                onPressed: () => _logoutDevice(d['id'] as String),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(d['os'] as String, style: AppTypography.bodySmall(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.location_solid, color: AppColors.textMutedDark, size: 12),
                            const SizedBox(width: 4),
                            Text(d['ip'] as String, style: const TextStyle(color: AppColors.textMutedDark, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.time, color: AppColors.textMutedDark, size: 12),
                            const SizedBox(width: 4),
                            Text(d['lastActive'] as String, style: const TextStyle(color: AppColors.accentGold, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardDark,
                side: const BorderSide(color: AppColors.error),
                foregroundColor: AppColors.error,
              ),
              onPressed: _logoutAllOtherDevices,
              icon: const Icon(CupertinoIcons.xmark_shield_fill, color: AppColors.error),
              label: const Text('Đăng xuất tất cả thiết bị khác'),
            ),
          ],
        ),
      ),
    );
  }
}
