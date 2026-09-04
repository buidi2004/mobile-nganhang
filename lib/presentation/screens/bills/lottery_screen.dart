import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({super.key});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  int _gameIdx = 0; // 0: Mega 6/45, 1: Power 6/55, 2: Keno
  final List<String> _games = ['Mega 6/45', 'Power 6/55', 'Keno'];
  final List<int> _selectedNumbers = [3, 12, 18, 27, 35, 42];
  int _ticketQuantity = 1;

  int get _maxNumber => _gameIdx == 0 ? 45 : (_gameIdx == 1 ? 55 : 80);
  int get _requiredCount => 6;
  double get _ticketPrice => 10000;
  double get _totalPrice => _ticketPrice * _ticketQuantity;

  void _generateRandomNumbers() {
    final rng = Random();
    final set = <int>{};
    while (set.length < _requiredCount) {
      set.add(rng.nextInt(_maxNumber) + 1);
    }
    final sorted = set.toList()..sort();
    setState(() {
      _selectedNumbers
        ..clear()
        ..addAll(sorted);
    });
  }

  void _toggleNumber(int n) {
    setState(() {
      if (_selectedNumbers.contains(n)) {
        _selectedNumbers.remove(n);
      } else {
        if (_selectedNumbers.length < _requiredCount) {
          _selectedNumbers.add(n);
          _selectedNumbers.sort();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Chỉ được chọn tối đa $_requiredCount số')),
          );
        }
      }
    });
  }

  void _handleBuy() {
    if (_selectedNumbers.length < _requiredCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng chọn đủ $_requiredCount số hoặc bấm Chọn ngẫu nhiên')),
      );
      return;
    }

    final gameName = _games[_gameIdx];
    final numbersStr = _selectedNumbers.join(', ');
    context.push(
      '/transfer/confirm?recipient=Vietlott $gameName ($numbersStr)&amount=$_totalPrice&note=Mua ve so $gameName',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Vé Số Vietlott Online'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jackpot Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF032B43), Color(0xFF0077B6), Color(0xFF00B4D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.bottomBarCyan.withOpacity(0.4), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bottomBarGlow.withOpacity(0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.ticket_fill, color: AppColors.accentGold, size: 40),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('JACKPOT 1 KHỦNG', style: AppTypography.labelLarge(color: AppColors.accentGold)),
                          const SizedBox(height: 2),
                          const Text(
                            '68.500.000.000 đ',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                          ),
                          Text('Kỳ quay thưởng hôm nay • 18:00', style: AppTypography.bodySmall(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Game Selector
              Row(
                children: List.generate(_games.length, (idx) {
                  final g = _games[idx];
                  final isSelected = _gameIdx == idx;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: idx < _games.length - 1 ? 8 : 0),
                      child: ChoiceChip(
                        label: Center(child: Text(g, style: const TextStyle(fontSize: 12))),
                        selected: isSelected,
                        onSelected: (val) {
                          setState(() {
                            _gameIdx = idx;
                            _generateRandomNumbers();
                          });
                        },
                        selectedColor: AppColors.primary,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Selected Numbers Ball Preview
              GlassCard(
                quality: GlassQuality.minimal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dãy số bạn chọn:', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                          TextButton.icon(
                            onPressed: _generateRandomNumbers,
                            icon: const Icon(CupertinoIcons.shuffle, size: 16),
                            label: const Text('Chọn ngẫu nhiên'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_requiredCount, (idx) {
                          final hasNum = idx < _selectedNumbers.length;
                          final val = hasNum ? _selectedNumbers[idx] : null;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: hasNum ? AppColors.primaryGradient : null,
                              color: hasNum ? null : AppColors.cardDark,
                              boxShadow: hasNum
                                  ? [
                                      BoxShadow(
                                        color: AppColors.bottomBarGlow.withOpacity(0.4),
                                        blurRadius: 8,
                                      ),
                                    ]
                                  : null,
                              border: Border.all(
                                color: hasNum ? AppColors.bottomBarCyan : AppColors.cardBorderDark,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                val != null ? (val < 10 ? '0$val' : '$val') : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text('Bảng chọn số (Chạm để chọn hoặc bỏ chọn)', style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
              const SizedBox(height: 10),

              // Number Matrix
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _maxNumber,
                itemBuilder: (context, idx) {
                  final numVal = idx + 1;
                  final isPicked = _selectedNumbers.contains(numVal);
                  return InkWell(
                    onTap: () => _toggleNumber(numVal),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: isPicked ? AppColors.primaryGradient : null,
                        color: isPicked ? null : AppColors.cardDark,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: isPicked
                            ? [
                                BoxShadow(
                                  color: AppColors.bottomBarGlow.withOpacity(0.35),
                                  blurRadius: 6,
                                ),
                              ]
                            : null,
                        border: Border.all(
                          color: isPicked ? AppColors.bottomBarCyan : AppColors.cardBorderDark,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          numVal < 10 ? '0$numVal' : '$numVal',
                          style: TextStyle(
                            color: isPicked ? Colors.white : AppColors.textSecondaryDark,
                            fontWeight: isPicked ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tổng tiền thanh toán:', style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                      Text(CurrencyFormatter.formatVND(_totalPrice), style: AppTypography.titleLarge(color: AppColors.emeraldGreen)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(CupertinoIcons.minus_circle_fill, color: AppColors.textSecondaryDark),
                        onPressed: _ticketQuantity > 1 ? () => setState(() => _ticketQuantity--) : null,
                      ),
                      Text('$_ticketQuantity vé', style: AppTypography.titleMedium(color: Colors.white)),
                      IconButton(
                        icon: const Icon(CupertinoIcons.plus_circle_fill, color: AppColors.primary),
                        onPressed: () => setState(() => _ticketQuantity++),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleBuy,
                child: const Text('Mua vé ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
