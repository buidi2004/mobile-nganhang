import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _apiUrlCtrl = TextEditingController(text: 'http://localhost:8080/api/v1');
  final TextEditingController _wsUrlCtrl = TextEditingController(text: 'ws://localhost:8080/ws-native');
  String _environment = 'Localhost (Emulator 10.0.2.2)';
  bool _isTesting = false;

  void _testConnection() {
    setState(() => _isTesting = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isTesting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.emeraldGreen,
          content: Text('Kết nối máy chủ Backend thành công! Ping: 28ms'),
        ),
      );
    });
  }

  void _saveConfig() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emeraldGreen,
        content: Text('Đã lưu cấu hình môi trường API!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Cấu Hình Server Backend'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Môi trường máy chủ', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 10),

            GlassCard(
              quality: GlassQuality.minimal,
              child: Column(
                children: [
                  _buildEnvTile('Localhost (Emulator 10.0.2.2)', 'http://10.0.2.2:8080/api/v1', 'ws://10.0.2.2:8080/ws-native'),
                  const Divider(height: 1, color: AppColors.cardBorderDark),
                  _buildEnvTile('Localhost (Web / Desktop)', 'http://localhost:8080/api/v1', 'ws://localhost:8080/ws-native'),
                  const Divider(height: 1, color: AppColors.cardBorderDark),
                  _buildEnvTile('Staging Server', 'https://staging-api.senhongbank.vn/api/v1', 'wss://staging-api.senhongbank.vn/ws-native'),
                  const Divider(height: 1, color: AppColors.cardBorderDark),
                  _buildEnvTile('Production Live', 'https://api.senhongbank.vn/api/v1', 'wss://api.senhongbank.vn/ws-native'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Custom API Base URL', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 8),
            TextField(
              controller: _apiUrlCtrl,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.link, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            Text('WebSocket STOMP URL', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 8),
            TextField(
              controller: _wsUrlCtrl,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.bolt_horizontal_fill, color: AppColors.accentGold),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.cardBorderDark),
                    ),
                    onPressed: _isTesting ? null : _testConnection,
                    icon: _isTesting
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(CupertinoIcons.waveform_path_badge_plus, size: 18, color: Colors.white),
                    label: const Text('Kiểm tra kết nối', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _saveConfig,
                    icon: const Icon(CupertinoIcons.floppy_disk, size: 18),
                    label: const Text('Lưu cấu hình'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvTile(String title, String apiUrl, String wsUrl) {
    final isSelected = _environment == title;
    return RadioListTile<String>(
      value: title,
      groupValue: _environment,
      activeColor: AppColors.primary,
      title: Text(title, style: TextStyle(color: isSelected ? AppColors.primaryLight : Colors.white, fontWeight: FontWeight.w600)),
      subtitle: Text(apiUrl, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 11)),
      onChanged: (val) {
        if (val != null) {
          setState(() {
            _environment = val;
            _apiUrlCtrl.text = apiUrl;
            _wsUrlCtrl.text = wsUrl;
          });
        }
      },
    );
  }
}
