class ApiResponse<T> {
  final bool success;
  final String? message;
  final String? errorCode;
  final T? data;

  const ApiResponse({required this.success, this.message, this.errorCode, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T? data) {
    return ApiResponse<T>(
      success: json['success'] == true,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      data: data,
    );
  }
}

Exception apiException(Map<String, dynamic> json) {
  return Exception(json['message'] ?? json['errorCode'] ?? 'Yêu cầu thất bại');
}

String extractErrorMessage(dynamic error) {
  if (error == null) return 'Đã xảy ra lỗi không xác định';
  
  // Xử lý chuỗi thông điệp
  final raw = error.toString().replaceAll('Exception: ', '').trim();
  
  if (raw.contains('temporarily locked') || raw.contains('too many failed') || raw.contains('LOCKED')) {
    return 'Tài khoản tạm thời bị khóa 15 phút do nhập sai mã PIN quá nhiều lần. Vui lòng thử lại sau hoặc cấp lại mã PIN.';
  }
  if (raw.contains('Invalid PIN') || raw.contains('INVALID_PIN')) {
    return 'Mã PIN giao dịch không chính xác. Vui lòng thử lại.';
  }
  if (raw.contains('PIN has not been set') || raw.contains('PIN_NOT_SET')) {
    return 'Bạn chưa thiết lập mã PIN giao dịch. Vui lòng cài đặt mã PIN.';
  }
  if (raw.contains('Phiên đăng nhập đã hết hạn')) {
    return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
  }
  if (raw.contains('403') || raw.contains('Forbidden')) {
    return 'Từ chối truy cập. Vui lòng kiểm tra lại quyền hạn hoặc đăng nhập lại.';
  }
  if (raw.contains('SocketException') || raw.contains('Failed host lookup')) {
    return 'Lỗi kết nối mạng. Vui lòng kiểm tra internet.';
  }
  if (raw.startsWith('DioException')) {
    // Cắt bỏ prefix DioException
    final parts = raw.split('\n');
    for (final p in parts) {
      if (!p.startsWith('DioException') && p.trim().isNotEmpty) {
        return p.replaceAll('Error: ', '').trim();
      }
    }
    return 'Lỗi xử lý hệ thống máy chủ. Vui lòng thử lại sau.';
  }
  
  return raw;
}