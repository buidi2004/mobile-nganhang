import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';
import 'package:sen_hong_bank/core/utils/currency_formatter.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final bool isHidden;
  final VoidCallback onToggleVisibility;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  final VoidCallback onTransfer;
  final VoidCallback onQr;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.isHidden,
    required this.onToggleVisibility,
    required this.onDeposit,
    required this.onWithdraw,
    required this.onTransfer,
    required this.onQr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: AppColors.balanceCardGradient,
          boxShadow: const [
            BoxShadow(
              color: Color(0x400096C7),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Header số dư
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Số dư khả dụng',
                      style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onToggleVisibility,
                      child: Icon(
                        isHidden ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(CupertinoIcons.shield_fill, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Ví Sen Hồng',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Row 2: Số tiền
            Text(
              CurrencyFormatter.formatMasked(balance, isHidden),
              style: AppTypography.balanceText(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Row 3: 4 Nút Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  icon: CupertinoIcons.arrow_down_circle_fill,
                  label: 'Nạp tiền',
                  onTap: onDeposit,
                ),
                _buildActionButton(
                  icon: CupertinoIcons.arrow_up_circle_fill,
                  label: 'Rút tiền',
                  onTap: onWithdraw,
                ),
                _buildActionButton(
                  icon: CupertinoIcons.paperplane_fill,
                  label: 'Chuyển tiền',
                  onTap: onTransfer,
                ),
                _buildActionButton(
                  icon: CupertinoIcons.qrcode,
                  label: 'Mã QR',
                  onTap: onQr,
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
