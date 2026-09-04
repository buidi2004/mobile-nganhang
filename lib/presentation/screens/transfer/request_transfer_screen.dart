import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class RequestTransferScreen extends StatefulWidget {
  const RequestTransferScreen({super.key});

  @override
  State<RequestTransferScreen> createState() => _RequestTransferScreenState();
}

class _RequestTransferScreenState extends State<RequestTransferScreen> {
  final TextEditingController _targetCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController(text: '150000');
  final TextEditingController _noteCtrl = TextEditingController(text: 'Tiền ăn trưa hôm nay');
  bool _isGroupSplit = false;
  int _splitMemberCount = 3;

  double get _eachPersonAmount {
    final total = double.tryParse(_amountCtrl.text) ?? 0;
    return _isGroupSplit && _splitMemberCount > 0 ? (total / _splitMemberCount) : total;
  }

  void _handleCreateRequest() {
    final total = double.tryParse(_amountCtrl.text) ?? 0;
    if (total <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số tiền hợp lệ')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.emeraldGreen),
            SizedBox(width: 8),
            Text('Đã tạo yêu cầu!', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isGroupSplit
                  ? 'Yêu cầu chia tiền nhóm ($_splitMemberCount người, mỗi người ${CurrencyFormatter.formatVND(_eachPersonAmount)}) đã được khởi tạo.'
                  : 'Yêu cầu chuyển ${CurrencyFormatter.formatVND(total)} đã gửi tới ${_targetCtrl.text.isEmpty ? "người nhận" : _targetCtrl.text}.',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Icon(CupertinoIcons.qrcode, color: AppColors.primary, size: 80),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text('Đã sao chép link thanh toán vào bộ nhớ đệm', style: TextStyle(fontSize: 12, color: AppColors.textMutedDark)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/transfer');
              }
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Yêu Cầu Chuyển Tiền / Chia Tiền'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Segmented Choice: Cá nhân / Chia nhóm
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Đòi tiền cá nhân')),
                      selected: !_isGroupSplit,
                      onSelected: (val) => setState(() => _isGroupSplit = false),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Chia tiền nhóm')),
                      selected: _isGroupSplit,
                      onSelected: (val) => setState(() => _isGroupSplit = true),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (!_isGroupSplit) ...[
                Text('Người trả tiền (SĐT hoặc Tên)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _targetCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.person_fill, color: AppColors.primary),
                    hintText: 'Nhập số điện thoại người cần nhắc nợ',
                    hintStyle: const TextStyle(color: AppColors.textMutedDark),
                    filled: true,
                    fillColor: AppColors.cardDark,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
              ] else ...[
                Text('Số người cùng chia (bao gồm cả bạn)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                const SizedBox(height: 8),
                GlassCard(
                  quality: GlassQuality.minimal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$_splitMemberCount người', style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(CupertinoIcons.minus_circle_fill, color: AppColors.textSecondaryDark),
                              onPressed: _splitMemberCount > 2 ? () => setState(() => _splitMemberCount--) : null,
                            ),
                            IconButton(
                              icon: const Icon(CupertinoIcons.plus_circle_fill, color: AppColors.primary),
                              onPressed: () => setState(() => _splitMemberCount++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              Text('Tổng số tiền cần nhận', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                style: AppTypography.displaySmall(color: AppColors.primaryLight),
                decoration: InputDecoration(
                  suffixText: 'đ',
                  suffixStyle: const TextStyle(color: AppColors.primaryLight, fontSize: 24),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),

              if (_isGroupSplit) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldGreen.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mỗi người cần trả:', style: AppTypography.bodyMedium(color: AppColors.textPrimaryDark)),
                      Text(CurrencyFormatter.formatVND(_eachPersonAmount), style: AppTypography.titleMedium(color: AppColors.emeraldGreen)),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),
              Text('Nội dung / Lời nhắn', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 8),
              TextField(
                controller: _noteCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.chat_bubble_text_fill, color: AppColors.primary),
                  hintText: 'Nhập lý do nhắc nợ / chia tiền',
                  hintStyle: const TextStyle(color: AppColors.textMutedDark),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),

              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: _handleCreateRequest,
                child: Text(_isGroupSplit ? 'Tạo liên kết chia tiền nhóm' : 'Gửi yêu cầu chuyển tiền'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
