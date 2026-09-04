import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/shell/main_tabs_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/cards/cards_screen.dart';
import '../screens/qr/scan_qr_screen.dart';
import '../screens/qr/my_qr_screen.dart';
import '../screens/promotions/promotions_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/auth/set_pin_screen.dart';
import '../screens/transfer/choose_recipient_screen.dart';
import '../screens/transfer/enter_amount_screen.dart';
import '../screens/transfer/confirm_transfer_screen.dart';
import '../screens/transfer/transfer_result_screen.dart';
import '../screens/history/transaction_history_screen.dart';
import '../screens/bills/bill_payment_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // 4 Main Tabs (StatefulShellRoute with FloatingGlassBottomBar)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainTabsScreen(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Tab 2: History
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              name: 'history',
              builder: (context, state) => const TransactionHistoryScreen(),
            ),
          ],
        ),
        // Tab 3: Promotions / Notifications
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/promotions',
              name: 'promotions',
              builder: (context, state) => const PromotionsScreen(),
            ),
          ],
        ),
        // Tab 4: More / Account
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              name: 'more',
              builder: (context, state) => const MoreScreen(),
            ),
          ],
        ),
      ],
    ),

    // QR Scanning & QR Codes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/scan-qr',
      name: 'scan-qr',
      builder: (context, state) => const ScanQRScreen(),
    ),
    // Cards Management
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/cards',
      name: 'cards',
      builder: (context, state) => const CardsScreen(),
    ),

    // QR Codes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/my-qr',
      name: 'my-qr',
      builder: (context, state) => const MyQRScreen(),
    ),

    // Auth Routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/auth/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/auth/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/auth/otp',
      name: 'otp',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'];
        return OtpVerificationScreen(phone: phone);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/auth/set-pin',
      name: 'set-pin',
      builder: (context, state) => const SetPinScreen(),
    ),

    // Transfer Routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/transfer',
      name: 'transfer',
      builder: (context, state) => const ChooseRecipientScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/transfer/amount',
      name: 'transfer-amount',
      builder: (context, state) {
        final recipient = state.uri.queryParameters['recipient'] ?? 'Ví Sen Hồng';
        return EnterAmountScreen(recipient: recipient);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/transfer/confirm',
      name: 'transfer-confirm',
      builder: (context, state) {
        final recipient = state.uri.queryParameters['recipient'] ?? 'Ví Sen Hồng';
        final amount = double.tryParse(state.uri.queryParameters['amount'] ?? '0') ?? 0;
        final note = state.uri.queryParameters['note'] ?? 'Chuyen tien';
        return ConfirmTransferScreen(
          recipient: recipient,
          amount: amount,
          note: note,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/transfer/result',
      name: 'transfer-result',
      builder: (context, state) {
        final recipient = state.uri.queryParameters['recipient'] ?? 'Ví Sen Hồng';
        final amount = double.tryParse(state.uri.queryParameters['amount'] ?? '0') ?? 0;
        final note = state.uri.queryParameters['note'] ?? 'Chuyen tien';
        return TransferResultScreen(
          recipient: recipient,
          amount: amount,
          note: note,
        );
      },
    ),



    // Bills & Utilities
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bills',
      name: 'bills',
      builder: (context, state) => const BillPaymentScreen(),
    ),
  ],
);
