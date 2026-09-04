import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  int _tabIndex = 0; // 0: Mở sổ mới, 1: Sổ của tôi
  final TextEditingController _amountCtrl = TextEditingController(text: '10000000');
  int _selectedTermIdx = 3; // 12 tháng

  final List<Map<String, dynamic>> _terms = [
    {'months': 1, 'rate': 3.5},
    {'months': 3, 'rate': 4.2},
    {'months': 6, 'rate': 5.5},
    {'months': 12, 'rate': 6.8},
    {'months': 24, 'rate': 7.2},
  ];

  double get _depositAmount => double.tryParse(_amountCtrl.text) ?? 0;
  double get _currentRate => (_terms[_selectedTermIdx]['rate'] as num).toDouble();
  int get _currentMonths => _terms[_selectedTermIdx]['months'] as int;

  double get _estimatedInterest {
    return _depositAmount * (_currentRate / 100.0) * (_currentMonths / 12.0);
  }

  final List<Map<String, dynamic>> _myPassbooks = [
    {
      'code': 'STK2026-0881',
      'principal': 50000000.0,
      'term': '12 tháng (6.8%/năm)',
      'openDate': '15/01/2026',
      'maturityDate': '15/01/2027',
      'expectedInterest': 3400000.0,
      'status': 'ĐANG HOẠT ĐỘNG',
    },
    {
      'code': 'STK2026-0129',
      'principal': 20000000.0,
      'term': '6 tháng (5.5%/năm)',
      'openDate': '01/06/2026',
      'maturityDate': '01/12/2026',
      'expectedInterest': 550000.0,
      'status': 'ĐANG HOẠT ĐỘNG',
    },
  ];

  void _handleOpenSavings() {
    if (_depositAmount < 1000000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số tiền gửi tiết kiệm tối thiểu là 1.000.000đ')),
      );
      return;
    }

    context.push(
      '/transfer/confirm?recipient=Tiết Kiệm Sen Hồng ($_currentMonths tháng - $_currentRate%/năm)&amount=$_depositAmount&note=Mo so tiet kiem $_currentMonths thang',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Tiết Kiệm Online'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Mở sổ tiết kiệm')),
                      selected: _tabIndex == 0,
                      onSelected: (val) => setState(() => _tabIndex = 0),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Sổ của tôi (2)')),
                      selected: _tabIndex == 1,
                      onSelected: (val) => setState(() => _tabIndex = 1),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _tabIndex == 0 ? _buildOpenTab() : _buildMyPassbooksTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpenTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Số tiền gửi tiết kiệm', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 8),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            style: AppTypography.displaySmall(color: AppColors.primaryLight),
            decoration: const InputDecoration(
              suffixText: ' đ',
              suffixStyle: TextStyle(color: AppColors.primaryLight, fontSize: 24),
              filled: true,
              fillColor: AppColors.cardDark,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),

          Text('Chọn kỳ hạn gửi', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
          const SizedBox(height: 10),

          // Term cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_terms.length, (idx) {
                final t = _terms[idx];
                final isSelected = _selectedTermIdx == idx;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => setState(() => _selectedTermIdx = idx),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient : null,
                        color: isSelected ? null : AppColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.bottomBarCyan : AppColors.cardBorderDark,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.bottomBarGlow.withOpacity(0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text('${t['months']} Tháng', style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimaryDark, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('${t['rate']}%', style: TextStyle(color: isSelected ? Colors.white : AppColors.emeraldGreen, fontSize: 18, fontWeight: FontWeight.w800)),
                          const Text('/năm', style: TextStyle(color: Colors.white70, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 28),

          // Calculator Preview Card
          GlassCard(
            quality: GlassQuality.minimal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dự tính tiền lãi khi đáo hạn', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tiền lãi dự kiến:', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                      Text(CurrencyFormatter.formatVND(_estimatedInterest), style: AppTypography.titleLarge(color: AppColors.emeraldGreen)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng nhận gốc + lãi:', style: AppTypography.bodyMedium(color: AppColors.textSecondaryDark)),
                      Text(CurrencyFormatter.formatVND(_depositAmount + _estimatedInterest), style: AppTypography.titleMedium(color: Colors.white)),
                    ],
                  ),
                  const Divider(height: 24, color: AppColors.cardBorderDark),
                  const Row(
                    children: [
                      Icon(CupertinoIcons.info_circle_fill, color: AppColors.accentGold, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('Tự động tái tục gốc + lãi khi đến ngày đáo hạn.', style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _handleOpenSavings,
            child: const Text('Mở sổ tiết kiệm ngay'),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPassbooksTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _myPassbooks.length,
      itemBuilder: (context, idx) {
        final pb = _myPassbooks[idx];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlassCard(
            quality: GlassQuality.minimal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pb['code']!, style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldGreen.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(pb['status']!, style: const TextStyle(color: AppColors.emeraldGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Tiền gốc gửi', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                  Text(CurrencyFormatter.formatVND(pb['principal'] as double), style: AppTypography.titleLarge(color: Colors.white)),
                  const Divider(height: 24, color: AppColors.cardBorderDark),
                  _buildRow('Kỳ hạn & Lãi suất', pb['term']!),
                  const SizedBox(height: 6),
                  _buildRow('Ngày gửi', pb['openDate']!),
                  const SizedBox(height: 6),
                  _buildRow('Ngày đáo hạn', pb['maturityDate']!),
                  const SizedBox(height: 6),
                  _buildRow('Lãi dự kiến', CurrencyFormatter.formatVND(pb['expectedInterest'] as double), isGreen: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 13)),
        Text(value, style: TextStyle(color: isGreen ? AppColors.emeraldGreen : Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
