import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class BankCardsScreen extends StatefulWidget {
  const BankCardsScreen({super.key});

  @override
  State<BankCardsScreen> createState() => _BankCardsScreenState();
}

class _BankCardsScreenState extends State<BankCardsScreen> {
  final List<Map<String, dynamic>> _banks = [
    {
      'id': 'b1',
      'bankName': 'Ngân hàng Ngoại Thương (Vietcombank)',
      'shortName': 'VCB',
      'accountNumber': '0071001234567',
      'holderName': 'BUI DUC VUONG',
      'isDefault': true,
    },
    {
      'id': 'b2',
      'bankName': 'Ngân hàng Kỹ Thương (Techcombank)',
      'shortName': 'TCB',
      'accountNumber': '1903344556677',
      'holderName': 'BUI DUC VUONG',
      'isDefault': false,
    },
    {
      'id': 'b3',
      'bankName': 'Ngân hàng Đầu tư & Phát triển (BIDV)',
      'shortName': 'BIDV',
      'accountNumber': '2151000987654',
      'holderName': 'BUI DUC VUONG',
      'isDefault': false,
    },
  ];

  void _showAddBankModal() {
    String selectedBank = 'VietinBank (CTG)';
    final accCtrl = TextEditingController();
    final holderCtrl = TextEditingController(text: 'BUI DUC VUONG');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Liên Kết Ngân Hàng Mới', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
                  IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(CupertinoIcons.xmark, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              Text('Chọn ngân hàng', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedBank,
                    dropdownColor: AppColors.cardDark,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    items: ['VietinBank (CTG)', 'MB Bank (MBB)', 'ACB', 'VPBank (VPB)', 'Sacombank (STB)']
                        .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedBank = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text('Số tài khoản ngân hàng', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 6),
              TextField(
                controller: accCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.number, color: AppColors.primary),
                  hintText: 'Nhập số tài khoản ngân hàng chính chủ',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Text('Tên chủ tài khoản', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
              const SizedBox(height: 6),
              TextField(
                controller: holderCtrl,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (accCtrl.text.trim().isEmpty) return;
                  Navigator.pop(ctx);
                  setState(() {
                    _banks.add({
                      'id': 'b_${DateTime.now().millisecondsSinceEpoch}',
                      'bankName': selectedBank,
                      'shortName': selectedBank.split(' ').first,
                      'accountNumber': accCtrl.text.trim(),
                      'holderName': holderCtrl.text.trim(),
                      'isDefault': false,
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.emeraldGreen,
                      content: Text('Liên kết tài khoản ngân hàng thành công!'),
                    ),
                  );
                },
                child: const Text('Xác nhận liên kết ngân hàng'),
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
        title: const Text('Tài Khoản Ngân Hàng'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Tài khoản ngân hàng liên kết', style: AppTypography.titleLarge(color: AppColors.textPrimaryDark)),
            const SizedBox(height: 6),
            Text('Liên kết tài khoản ngân hàng nội địa để nạp và rút tiền tức thì', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
            const SizedBox(height: 16),

            ..._banks.map((b) {
              final isDefault = b['isDefault'] as bool;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: Material(type: MaterialType.transparency, child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.18),
                      child: Text(
                        b['shortName'] as String,
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                    title: Text('${b['shortName']} - ${b['accountNumber']}', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text('${b['holderName']} • ${b['bankName']}', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: isDefault
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.emeraldGreen.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('Nhận tiền', style: TextStyle(color: AppColors.emeraldGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                        : IconButton(
                            icon: const Icon(CupertinoIcons.ellipsis, color: AppColors.textMutedDark),
                            onPressed: () => _showBankOptions(b),
                          ),
                  )),
                ),
              );
            }),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddBankModal,
              icon: const Icon(CupertinoIcons.plus_circle_fill),
              label: const Text('Thêm tài khoản ngân hàng mới'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBankOptions(Map<String, dynamic> b) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(type: MaterialType.transparency, child: ListTile(
              leading: const Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.emeraldGreen),
              title: const Text('Đặt làm tài khoản nhận tiền mặc định', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  for (var item in _banks) {
                    item['isDefault'] = item['id'] == b['id'];
                  }
                });
              },
            )),
            Material(type: MaterialType.transparency, child: ListTile(
              leading: const Icon(CupertinoIcons.trash_fill, color: AppColors.error),
              title: const Text('Hủy liên kết tài khoản này', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _banks.removeWhere((item) => item['id'] == b['id']);
                });
              },
            )),
          ],
        ),
      ),
    );
  }
}
