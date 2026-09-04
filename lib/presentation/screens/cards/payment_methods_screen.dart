import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _methods = [
    {
      'id': '1',
      'title': 'Ví Sen Hồng (Tài khoản chính)',
      'subtitle': 'Số dư: 12.580.000 đ',
      'icon': CupertinoIcons.money_dollar_circle_fill,
      'isDefault': true,
      'type': 'WALLET',
    },
    {
      'id': '2',
      'title': 'Visa Platinum Quốc Tế',
      'subtitle': '•••• •••• •••• 4589 • Hết hạn: 08/28',
      'icon': CupertinoIcons.creditcard_fill,
      'isDefault': false,
      'type': 'CARD',
    },
    {
      'id': '3',
      'title': 'Mastercard World Elite',
      'subtitle': '•••• •••• •••• 9921 • Hết hạn: 11/27',
      'icon': CupertinoIcons.creditcard_fill,
      'isDefault': false,
      'type': 'CARD',
    },
  ];

  void _showAddCardModal() {
    final numberCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final expiryCtrl = TextEditingController();
    final cvvCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thêm Thẻ Quốc Tế Mới', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                  IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(CupertinoIcons.xmark, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              Text('Số thẻ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 6),
              TextField(
                controller: numberCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.creditcard, color: AppColors.primary),
                  hintText: '4xxx xxxx xxxx xxxx',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Text('Tên in trên thẻ', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 6),
              TextField(
                controller: nameCtrl,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                  hintText: 'NGUYEN VAN A',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ngày hết hạn', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: expiryCtrl,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: const TextStyle(color: AppColors.textMutedDark),
                            filled: true,
                            fillColor: const Color(0xFF1E293B),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã CVV/CVC', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: cvvCtrl,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '•••',
                            hintStyle: const TextStyle(color: AppColors.textMutedDark),
                            filled: true,
                            fillColor: const Color(0xFF1E293B),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _methods.add({
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'title': 'Visa Card (${numberCtrl.text.isEmpty ? "*9999" : numberCtrl.text.substring(numberCtrl.text.length - 4)})',
                      'subtitle': 'Hết hạn: ${expiryCtrl.text.isEmpty ? "12/28" : expiryCtrl.text}',
                      'icon': CupertinoIcons.creditcard_fill,
                      'isDefault': false,
                      'type': 'CARD',
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.emeraldGreen,
                      content: Text('Liên kết thẻ quốc tế thành công!'),
                    ),
                  );
                },
                child: const Text('Lưu & Xác thực thẻ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Nguồn Tiền & Phương Thức'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Phương thức thanh toán đã liên kết', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 8),
            Text('Sử dụng để thanh toán hóa đơn, nạp tiền và chi tiêu trực tuyến', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 16),

            ..._methods.map((m) {
              final isDefault = m['isDefault'] as bool;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(m['icon'] as IconData, color: AppColors.primary),
                    ),
                    title: Text(m['title'] as String, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text(m['subtitle'] as String, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: isDefault
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.emeraldGreen.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('Mặc định', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                        : IconButton(
                            icon: const Icon(CupertinoIcons.ellipsis, color: AppColors.textMutedDark),
                            onPressed: () {
                              _showOptionSheet(m);
                            },
                          ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddCardModal,
              icon: const Icon(CupertinoIcons.plus_circle_fill),
              label: const Text('Thêm thẻ quốc tế mới (Visa/Mastercard)'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionSheet(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.emeraldGreen),
              title: const Text('Đặt làm phương thức mặc định', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  for (var m in _methods) {
                    m['isDefault'] = m['id'] == item['id'];
                  }
                });
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.trash_fill, color: AppColors.error),
              title: const Text('Hủy liên kết thẻ này', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _methods.removeWhere((m) => m['id'] == item['id']);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
