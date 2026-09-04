import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class ChooseRecipientScreen extends StatefulWidget {
  const ChooseRecipientScreen({super.key});

  @override
  State<ChooseRecipientScreen> createState() => _ChooseRecipientScreenState();
}

class _ChooseRecipientScreenState extends State<ChooseRecipientScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0; // 0: Nội bộ Sen Hồng, 1: Liên ngân hàng 24/7

  final List<Map<String, String>> _recentBeneficiaries = const [
    {'name': 'NGUYEN VAN A', 'account': '0901234567', 'bank': 'Ví Sen Hồng'},
    {'name': 'TRAN THI B', 'account': '1903445566', 'bank': 'Techcombank'},
    {'name': 'LE HOANG C', 'account': '0071001234', 'bank': 'Vietcombank'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Chuyển Tiền')),
      body: SafeArea(
        child: Column(
          children: [
            // Tabs selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTab == 0 ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Ví tới Ví (Nội bộ)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTab == 0 ? Colors.white : AppColors.textSecondaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTab == 1 ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Liên ngân hàng (Napas)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTab == 1 ? Colors.white : AppColors.textSecondaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _selectedTab == 0 ? 'Nhập SĐT hoặc Mã ví Sen Hồng' : 'Nhập số tài khoản ngân hàng',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: const Icon(CupertinoIcons.qrcode, color: AppColors.primaryLight),
                    onPressed: () => context.push('/scan-qr'),
                  ),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                onSubmitted: (val) {
                  if (val.isNotEmpty) {
                    context.push('/transfer/amount?recipient=$val');
                  }
                },
              ),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Người thụ hưởng gần đây', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              ),
            ),
            const SizedBox(height: 8),

            // Recent Beneficiaries
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _recentBeneficiaries.length,
                itemBuilder: (context, index) {
                  final b = _recentBeneficiaries[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GlassCard(
                      quality: GlassQuality.minimal,
                      child: ListTile(
                        onTap: () => context.push('/transfer/amount?recipient=${b['name']}'),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          child: Text(b['name']![0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(b['name']!, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                        subtitle: Text('${b['bank']} • ${b['account']}', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
