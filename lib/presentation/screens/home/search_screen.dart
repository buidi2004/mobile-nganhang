import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';
import 'package:sen_hong_bank/core/theme/app_typography.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  final List<Map<String, dynamic>> _features = const [
    {'title': 'Chuyển tiền Napas 24/7', 'sub': 'Chuyển liên ngân hàng hoặc nội bộ', 'icon': CupertinoIcons.paperplane_fill, 'route': '/transfer'},
    {'title': 'Nạp tiền vào ví', 'sub': 'Nạp từ thẻ ngân hàng liên kết', 'icon': CupertinoIcons.arrow_down_circle_fill, 'route': '/deposit'},
    {'title': 'Rút tiền về ngân hàng', 'sub': 'Rút tiền tức thì miễn phí', 'icon': CupertinoIcons.arrow_up_circle_fill, 'route': '/withdraw'},
    {'title': 'Nạp tiền điện thoại', 'sub': 'Chiết khấu 3% Viettel, Vina, Mobi', 'icon': CupertinoIcons.device_phone_portrait, 'route': '/bills/phone-recharge'},
    {'title': 'Thanh toán tiền điện EVN', 'sub': 'Tra cứu và nộp tiền điện toàn quốc', 'icon': CupertinoIcons.bolt_fill, 'route': '/bills/input?service=Tiền điện'},
    {'title': 'Thanh toán tiền nước sinh hoạt', 'sub': 'Sawaco, Viwaco, Chợ Lớn', 'icon': CupertinoIcons.drop_fill, 'route': '/bills/input?service=Tiền nước'},
    {'title': 'Vé số Vietlott online', 'sub': 'Mega 6/45, Power 6/55, Keno', 'icon': CupertinoIcons.ticket_fill, 'route': '/bills/lottery'},
    {'title': 'Mở sổ tiết kiệm online', 'sub': 'Lãi suất hấp dẫn lên đến 7.2%/năm', 'icon': CupertinoIcons.money_dollar_circle_fill, 'route': '/bills/savings'},
    {'title': 'Vay nhanh tiêu dùng', 'sub': 'Duyệt hạn mức tự động 50 triệu', 'icon': CupertinoIcons.chart_bar_alt_fill, 'route': '/bills/quick-loan'},
    {'title': 'Quản lý thẻ Sen Hồng', 'sub': 'Khóa/mở thẻ, xem thông tin thẻ', 'icon': CupertinoIcons.creditcard_fill, 'route': '/cards'},
    {'title': 'Định danh điện tử (eKYC)', 'sub': 'Chụp CCCD nâng hạn mức lên 100tr', 'icon': CupertinoIcons.person_crop_circle_badge_checkmark, 'route': '/profile/ekyc'},
    {'title': 'Danh bạ người thụ hưởng', 'sub': 'Quản lý tài khoản đã lưu', 'icon': CupertinoIcons.person_2_fill, 'route': '/beneficiaries'},
    {'title': 'Cài đặt bảo mật & Smart OTP', 'sub': 'Đổi mã PIN, FaceID, 2FA', 'icon': CupertinoIcons.lock_shield_fill, 'route': '/settings/security'},
  ];

  List<Map<String, dynamic>> get _results {
    if (_query.trim().isEmpty) return _features;
    return _features.where((f) {
      final t = (f['title'] as String).toLowerCase();
      final s = (f['sub'] as String).toLowerCase();
      final q = _query.toLowerCase();
      return t.contains(q) || s.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _searchCtrl,
          autofocus: true,
          onChanged: (val) => setState(() => _query = val),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Tìm chức năng, dịch vụ, hóa đơn...',
            hintStyle: const TextStyle(color: AppColors.textMutedDark),
            border: InputBorder.none,
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(CupertinoIcons.clear_circled_solid, color: AppColors.textMutedDark, size: 18),
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              _query.isEmpty ? 'Dịch vụ phổ biến gợi ý' : 'Kết quả tìm kiếm (${_results.length})',
              style: AppTypography.titleMedium(color: AppColors.textSecondaryDark),
            ),
            const SizedBox(height: 12),

            ..._results.map((f) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  quality: GlassQuality.minimal,
                  child: Material(type: MaterialType.transparency, child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onTap: () => context.push(f['route'] as String),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(f['icon'] as IconData, color: AppColors.primary, size: 20),
                    ),
                    title: Text(f['title'] as String, style: AppTypography.titleMedium(color: AppColors.textPrimaryDark)),
                    subtitle: Text(f['sub'] as String, style: AppTypography.bodySmall(color: AppColors.textSecondaryDark)),
                    trailing: const Icon(CupertinoIcons.chevron_forward, color: AppColors.textMutedDark, size: 16),
                  )),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
