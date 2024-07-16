import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiKey;
  final Map<String, String> _cache = {}; // Simple in-memory cache

  ApiService() : _apiKey = dotenv.env['OPENAI_API_KEY']! {
    if (_apiKey.isEmpty) {
      throw Exception('API key is not set');
    }
  }

  Future<String> sendMessage(String message) async {
    // Check if the response is already in the cache
    if (_cache.containsKey(message)) {
      return _cache[message]!;
    }

    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message}
        ],
        'max_tokens': 50, // Reduced max_tokens value
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseMessage = data['choices'][0]['message']['content'];

      // Store the response in the cache
      _cache[message] = responseMessage;

      return responseMessage;
    } else {
      final errorData = jsonDecode(response.body);
      if (errorData['error']['type'] == 'insufficient_quota') {
        throw Exception('Quota exceeded. Please check your plan and billing details.');
      }
      throw Exception('Failed to load response: ${errorData['error']['message']}');
    }
  }

  // Method to send batch requests
  Future<List<String>> sendBatchMessages(List<String> messages) async {
    // Combine messages into a single request to minimize API calls
    final combinedMessage = messages.join('\n');

    // Check if the combined response is already in the cache
    if (_cache.containsKey(combinedMessage)) {
      return _cache[combinedMessage]!.split('\n');
    }

    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': combinedMessage}
        ],
        'max_tokens': 150, // Adjusted max_tokens for combined messages
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseMessage = data['choices'][0]['message']['content'];

      // Store the combined response in the cache
      _cache[combinedMessage] = responseMessage;

      return responseMessage.split('\n');
    } else {
      final errorData = jsonDecode(response.body);
      if (errorData['error']['type'] == 'insufficient_quota') {
        throw Exception('Quota exceeded. Please check your plan and billing details.');
      }
      throw Exception('Failed to load response: ${errorData['error']['message']}');
    }
  }
}
