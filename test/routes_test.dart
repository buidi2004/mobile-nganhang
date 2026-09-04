import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sen_hong_bank/presentation/routes/app_router.dart';

void main() {
  test('All required routes exist in appRouter', () {
    final expectedPaths = [
      '/',
      '/history',
      '/promotions',
      '/more',
      '/auth/login',
      '/auth/register',
      '/auth/otp',
      '/auth/set-pin',
      '/auth/forgot-password',
      '/auth/reset-password',
      '/auth/forgot-pin',
      '/auth/terms',
      '/transfer',
      '/transfer/amount',
      '/transfer/confirm',
      '/transfer/2fa-otp',
      '/transfer/result',
      '/transfer/request',
      '/beneficiaries',
      '/scan-qr',
      '/my-qr',
      '/deposit',
      '/deposit/confirm',
      '/withdraw',
      '/withdraw/confirm',
      '/history/detail',
      '/bills',
      '/bills/input',
      '/bills/confirm',
      '/bills/phone-recharge',
      '/bills/lottery',
      '/bills/savings',
      '/bills/quick-loan',
      '/cards',
      '/payment-methods',
      '/bank-cards',
      '/profile',
      '/profile/identity',
      '/profile/kyc-level',
      '/profile/ekyc',
      '/profile/digital-signature',
      '/profile/email-settings',
      '/settings/security',
      '/settings/devices',
      '/settings',
      '/settings/config',
      '/notifications',
      '/search',
      '/referral',
      '/support/help-center',
      '/support/live-chat',
    ];

    final registeredPaths = <String>{};

    void collectRoutes(List<RouteBase> routes) {
      for (final r in routes) {
        if (r is GoRoute) {
          registeredPaths.add(r.path);
          if (r.routes.isNotEmpty) {
            collectRoutes(r.routes);
          }
        } else if (r is ShellRoute) {
          collectRoutes(r.routes);
        } else if (r is StatefulShellRoute) {
          for (final branch in r.branches) {
            collectRoutes(branch.routes);
          }
        }
      }
    }

    collectRoutes(appRouter.configuration.routes);

    for (final path in expectedPaths) {
      expect(
        registeredPaths.contains(path),
        isTrue,
        reason: 'Route $path must be registered in appRouter',
      );
    }
    expect(registeredPaths.length, greaterThanOrEqualTo(50));
  });
}
