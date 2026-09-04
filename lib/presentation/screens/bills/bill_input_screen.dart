import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class BillInputScreen extends StatefulWidget {
  final String? serviceType;
  const BillInputScreen({super.key, this.serviceType});

  @override
  State<BillInputScreen> createState() => _BillInputScreenState();
}

class _BillInputScreenState extends State<BillInputScreen> {
  final TextEditingController _customerCodeCtrl = TextEditingController(text: 'PE0100023456');
  int _selectedProviderIdx = 0;
  bool _isLoading = false;

  final List<Map<String, String>> _providers = const [
    {'name': 'EVN Hà Nội', 'area': 'Miền Bắc', 'code': 'EVNHN'},
    {'name': 'EVN TP.HCM', 'area': 'Miền Nam', 'code': 'EVNHCM'},
    {'name': 'EVN Miền Trung', 'area': 'Miền Trung', 'code': 'EVNCPC'},
    {'name': 'Nước Chợ Lớn (Sawaco)', 'area': 'TP.HCM', 'code': 'WATER_CHOLON'},
    {'name': 'Nước Viwaco', 'area': 'Hà Nội', 'code': 'WATER_VIWACO'},
    {'name': 'VNPT Telecom', 'area': 'Toàn quốc', 'code': 'INTERNET_VNPT'},
    {'name': 'FPT Telecom', 'area': 'Toàn quốc', 'code': 'INTERNET_FPT'},
  ];

  void _handleLookup() {
    final code = _customerCodeCtrl.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập mã khách hàng / mã danh bộ')),
      );
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final provider = _providers[_selectedProviderIdx]['name']!;
      context.push('/bills/confirm?service=${widget.serviceType ?? "Hóa đơn"}&provider=$provider&code=$code');
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.serviceType ?? 'Hóa đơn dịch vụ';

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: Text('Tra Cứu: $service'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chọn nhà cung cấp dịch vụ', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 10),

              // Provider Selector
              GlassCard(
                quality: GlassQuality.minimal,
                child: Column(
                  children: List.generate(_providers.length, (idx) {
                    final p = _providers[idx];
                    final isSelected = _selectedProviderIdx == idx;
                    final isLast = idx == _providers.length - 1;
                    return Column(
                      children: [
                        ListTile(
                          onTap: () => setState(() => _selectedProviderIdx = idx),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.15),
                            child: const Icon(CupertinoIcons.building_2_fill, color: AppColors.primary, size: 18),
                          ),
                          title: Text(p['name']!, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                          subtitle: Text(p['area']!, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                          trailing: isSelected
                              ? const Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.primary)
                              : const Icon(CupertinoIcons.circle, color: AppColors.textMutedDark),
                        ),
                        if (!isLast) const Divider(height: 1, indent: 56, color: AppColors.cardBorderDark),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),
              Text('Mã khách hàng / Mã danh bộ', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _customerCodeCtrl,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.barcode_viewfinder, color: AppColors.primary),
                  hintText: 'Ví dụ: PE0100023456',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  helperText: 'Xem mã trên tin nhắn SMS hoặc giấy báo cước hàng tháng',
                  helperStyle: const TextStyle(color: AppColors.textSecondaryDark),
                ),
              ),

              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLookup,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Tra cứu nợ cước'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
