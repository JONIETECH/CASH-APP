import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendNotification(String userId, String title, String message) async {
  final response = await http.post(
    Uri.parse('YOUR_SUPABASE_FUNCTION_URL'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'user_id': userId,
      'title': title,
      'message': message,
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}
