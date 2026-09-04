import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class PhoneRechargeScreen extends StatefulWidget {
  const PhoneRechargeScreen({super.key});

  @override
  State<PhoneRechargeScreen> createState() => _PhoneRechargeScreenState();
}

class _PhoneRechargeScreenState extends State<PhoneRechargeScreen> {
  int _mode = 0; // 0: Nạp trực tiếp, 1: Mua mã thẻ
  final TextEditingController _phoneCtrl = TextEditingController(text: '0901234567');
  int _selectedTelcoIdx = 0;
  int _selectedAmountIdx = 3; // 100,000đ

  final List<String> _telcos = ['Viettel', 'Vinaphone', 'Mobifone', 'Vietnamobile', 'Wintel'];
  final List<double> _amounts = [10000, 20000, 50000, 100000, 200000, 500000];

  double get _discountRate => 0.03; // 3% chiết khấu
  double get _selectedAmount => _amounts[_selectedAmountIdx];
  double get _finalAmount => _selectedAmount * (1 - _discountRate);

  void _handlePay() {
    final telco = _telcos[_selectedTelcoIdx];
    final modeName = _mode == 0 ? 'Nạp ĐT' : 'Mua thẻ';
    final target = _mode == 0 ? _phoneCtrl.text : telco;

    context.push(
      '/transfer/confirm?recipient=$modeName $telco ($target)&amount=$_finalAmount&note=Nap tien dien thoai $telco',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Nạp Tiền Điện Thoại'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Segmented Tab: Nạp trực tiếp / Mua mã thẻ
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Nạp trực tiếp')),
                      selected: _mode == 0,
                      onSelected: (val) => setState(() => _mode = 0),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Mua mã thẻ cào')),
                      selected: _mode == 1,
                      onSelected: (val) => setState(() => _mode = 1),
                      selectedColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (_mode == 0) ...[
                Text('Số điện thoại nạp', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.phone_fill, color: AppColors.primary),
                    suffixIcon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark, color: AppColors.primaryLight),
                    hintText: 'Nhập số điện thoại cần nạp',
                    hintStyle: const TextStyle(color: AppColors.textMutedDark),
                    filled: true,
                    fillColor: AppColors.cardDark,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              Text('Chọn nhà mạng', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_telcos.length, (idx) {
                    final t = _telcos[idx];
                    final isSelected = _selectedTelcoIdx == idx;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => setState(() => _selectedTelcoIdx = idx),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: isSelected ? AppColors.primaryGradient : null,
                            color: isSelected ? null : AppColors.cardDark,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.bottomBarGlow.withOpacity(0.35),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                            border: Border.all(
                              color: isSelected ? AppColors.bottomBarCyan : AppColors.cardBorderDark,
                            ),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textSecondaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),
              Text('Chọn mệnh giá', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: _amounts.length,
                itemBuilder: (context, idx) {
                  final amt = _amounts[idx];
                  final isSelected = _selectedAmountIdx == idx;
                  return InkWell(
                    onTap: () => setState(() => _selectedAmountIdx = idx),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.bottomBarCyan.withOpacity(0.18) : AppColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.bottomBarGlow.withOpacity(0.30),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                        border: Border.all(
                          color: isSelected ? AppColors.bottomBarCyan : AppColors.cardBorderDark,
                          width: isSelected ? 1.8 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CurrencyFormatter.formatVND(amt),
                            style: TextStyle(
                              color: isSelected ? AppColors.primaryLight : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'CK 3%',
                            style: TextStyle(color: AppColors.emeraldGreen, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // Summary Box
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Giá thanh toán (Đã trừ 3%):', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                          const SizedBox(height: 2),
                          Text(CurrencyFormatter.formatVND(_finalAmount), style: AppTypography.titleLarge(color: AppColors.emeraldGreen)),
                        ],
                      ),
                      Text(
                        'Tiết kiệm ${CurrencyFormatter.formatVND(_selectedAmount * _discountRate)}',
                        style: const TextStyle(color: AppColors.accentGold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _handlePay,
                child: Text(_mode == 0 ? 'Nạp tiền ngay' : 'Mua mã thẻ cào'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
