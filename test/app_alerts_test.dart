import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sen_hong_bank/presentation/widgets/app_alerts.dart';

void main() {
  testWidgets('AppAlerts renders warning toast correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  AppAlerts.showWarning(
                    context,
                    'Số dư ví không đủ để thực hiện giao dịch',
                    title: 'Cảnh báo số dư',
                    actionLabel: 'Nạp tiền',
                    onAction: () {},
                  );
                },
                child: const Text('Show Toast'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Toast'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Cảnh báo số dư'), findsOneWidget);
    expect(find.text('Số dư ví không đủ để thực hiện giao dịch'), findsOneWidget);
    expect(find.text('Nạp tiền'), findsOneWidget);
  });

  testWidgets('InlineWarningBanner renders title and message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InlineWarningBanner(
            title: 'Lưu ý bảo mật',
            message: 'Không chia sẻ mã PIN cho bất kỳ ai',
          ),
        ),
      ),
    );

    expect(find.text('Lưu ý bảo mật'), findsOneWidget);
    expect(find.text('Không chia sẻ mã PIN cho bất kỳ ai'), findsOneWidget);
  });

  testWidgets('AppAlerts.showSecurityConfirmDialog displays and confirms', (tester) async {
    bool? confirmed;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  confirmed = await AppAlerts.showSecurityConfirmDialog(
                    context,
                    title: 'Xác nhận chuyển khoản',
                    message: 'Quý khách có chắc chắn muốn chuyển tiền không?',
                    subMessage: 'Giao dịch không thể hoàn tác sau khi gửi đi.',
                    confirmText: 'Đồng ý',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Xác nhận chuyển khoản'), findsOneWidget);
    expect(find.text('Quý khách có chắc chắn muốn chuyển tiền không?'), findsOneWidget);
    expect(find.text('Giao dịch không thể hoàn tác sau khi gửi đi.'), findsOneWidget);

    await tester.tap(find.text('Đồng ý'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });
}
