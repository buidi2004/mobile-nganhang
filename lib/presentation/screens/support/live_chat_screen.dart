import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sen_hong_bank/core/theme/app_colors.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'agent',
      'name': 'CSKH Sen Hồng (Thu Hằng)',
      'text': 'Xin chào quý khách BÙI ĐỨC VƯƠNG! Em là chuyên viên hỗ trợ trực tuyến 24/7 của Ví Sen Hồng. Em có thể hỗ trợ gì cho quý khách ạ?',
      'time': '10:30',
    },
    {
      'sender': 'user',
      'name': 'Tôi',
      'text': 'Chào bạn, cho mình hỏi giao dịch chuyển tiền Napas 247 hạn mức tối đa một ngày là bao nhiêu vậy?',
      'time': '10:31',
    },
    {
      'sender': 'agent',
      'name': 'CSKH Sen Hồng (Thu Hằng)',
      'text': 'Dạ hiện tại tài khoản của quý khách đã hoàn tất eKYC Cấp 2, hạn mức chuyển tiền liên ngân hàng là 100.000.000đ/ngày. Nếu cần nâng lên 500.000.000đ, quý khách chỉ cần kích hoạt Chữ ký số Smart OTP tại mục Hồ sơ cá nhân ạ!',
      'time': '10:32',
    },
  ];

  final List<String> _quickReplies = [
    'Tra cứu GD chưa nhận tiền',
    'Cách đổi mã PIN giao dịch',
    'Hỗ trợ nâng hạn mức eKYC',
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'sender': 'user',
        'name': 'Tôi',
        'text': text.trim(),
        'time': 'Vừa xong',
      });
      _msgCtrl.clear();
    });

    _scrollToBottom();

    // Auto agent reply simulation
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'sender': 'agent',
          'name': 'CSKH Sen Hồng (Thu Hằng)',
          'text': 'Cảm ơn quý khách đã gửi thông tin. Em đã tiếp nhận và đang tiến hành kiểm tra trên hệ thống xử lý giao dịch. Quý khách vui lòng đợi trong giây lát nhé ạ!',
          'time': 'Vừa xong',
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 20),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(radius: 5, backgroundColor: AppColors.emeraldGreen),
                ),
              ],
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CSKH Sen Hồng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Trực tuyến 24/7 • Phản hồi tức thì', style: TextStyle(fontSize: 11, color: AppColors.emeraldGreen)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, idx) {
                  final msg = _messages[idx];
                  final isUser = msg['sender'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isUser ? AppColors.primaryGradient : null,
                        color: isUser ? null : AppColors.cardDark,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 16),
                        ),
                        border: isUser ? null : Border.all(color: AppColors.cardBorderDark),
                        boxShadow: isUser
                            ? [
                                BoxShadow(
                                  color: AppColors.bottomBarGlow.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (!isUser)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(msg['name']!, style: const TextStyle(fontSize: 11, color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
                            ),
                          Text(
                            msg['text']!,
                            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.35),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg['time']!,
                            style: TextStyle(color: isUser ? Colors.white70 : AppColors.textMutedDark, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Quick suggestion chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: _quickReplies.map((qr) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      backgroundColor: AppColors.cardDark,
                      label: Text(qr, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      onPressed: () => _sendMessage(qr),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Message Composer
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                color: AppColors.cardDark,
                border: Border(top: BorderSide(color: AppColors.cardBorderDark)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.paperclip, color: AppColors.primaryLight),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn hỗ trợ...',
                        hintStyle: const TextStyle(color: AppColors.textMutedDark),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.bottomBarGlow.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.paperplane_fill, color: Colors.white, size: 18),
                      onPressed: () => _sendMessage(_msgCtrl.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
