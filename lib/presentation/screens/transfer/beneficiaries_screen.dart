import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _keyword = '';

  final List<Map<String, String>> _beneficiaries = [
    {
      'id': '1',
      'name': 'NGUYEN VAN A',
      'nickname': 'Anh An đồng nghiệp',
      'bank': 'Vietcombank',
      'acc': '0071008899668',
      'phone': '0912345678',
    },
    {
      'id': '2',
      'name': 'TRAN THI MAI',
      'nickname': 'Chị Mai kế toán',
      'bank': 'Techcombank',
      'acc': '190388221199',
      'phone': '0987654321',
    },
    {
      'id': '3',
      'name': 'LE QUANG DUNG',
      'nickname': 'Dũng chủ trọ',
      'bank': 'MB Bank',
      'acc': '080010992288',
      'phone': '0908889999',
    },
    {
      'id': '4',
      'name': 'PHAM MINH TUAN',
      'nickname': 'Tuấn bạn cấp 3',
      'bank': 'Ví Sen Hồng',
      'acc': '0977665544',
      'phone': '0977665544',
    },
  ];

  List<Map<String, String>> get _filtered {
    if (_keyword.isEmpty) return _beneficiaries;
    return _beneficiaries.where((b) {
      return b['name']!.toLowerCase().contains(_keyword.toLowerCase()) ||
          b['nickname']!.toLowerCase().contains(_keyword.toLowerCase()) ||
          b['acc']!.contains(_keyword) ||
          b['phone']!.contains(_keyword);
    }).toList();
  }

  void _editNickname(Map<String, String> b) {
    final nickCtrl = TextEditingController(text: b['nickname']);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text('Đổi Biệt Danh', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: nickCtrl,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'Nhập biệt danh dễ nhớ'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() => b['nickname'] = nickCtrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteBeneficiary(Map<String, String> b) {
    setState(() => _beneficiaries.removeWhere((item) => item['id'] == b['id']));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa người thụ hưởng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Danh Bạ Thụ Hưởng'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() => _keyword = val),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.primary),
                  hintText: 'Tìm theo tên, SĐT, số tài khoản...',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Text('Không tìm thấy người thụ hưởng phù hợp', style: AppTypography.bodyMedium(color: AppColors.textMutedDark)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: _filtered.length,
                      itemBuilder: (context, idx) {
                        final b = _filtered[idx];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassCard(
                            quality: GlassQuality.minimal,
                            child: Material(type: MaterialType.transparency, child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              onTap: () {
                                context.push(
                                  '/transfer/amount?recipient=${b['name']} (${b['bank']} ${b['acc']})&amount=100000&note=Chuyen tien',
                                );
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.primaryGradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.bottomBarGlow.withOpacity(0.35),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: const Color(0xFF0F172A),
                                  child: Text(
                                    b['name']!.split(' ').last.substring(0, 1),
                                    style: const TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(child: Text(b['name']!, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark))),
                                  const Icon(CupertinoIcons.paperplane_fill, size: 16, color: AppColors.bottomBarCyan),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2),
                                  Text(b['nickname']!, style: const TextStyle(color: AppColors.accentGold, fontSize: 12, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 2),
                                  Text('${b['bank']} • ${b['acc']}', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                icon: const Icon(CupertinoIcons.ellipsis, color: AppColors.textMutedDark),
                                color: AppColors.cardDark,
                                onSelected: (action) {
                                  if (action == 'edit') _editNickname(b);
                                  if (action == 'delete') _deleteBeneficiary(b);
                                },
                                itemBuilder: (ctx) => [
                                  const PopupMenuItem(value: 'edit', child: Text('Sửa biệt danh', style: TextStyle(color: Colors.white))),
                                  const PopupMenuItem(value: 'delete', child: Text('Xóa người này', style: TextStyle(color: AppColors.error))),
                                ],
                              ),
                            )),
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
