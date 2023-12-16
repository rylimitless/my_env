import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.insert(0, {'role': 'user', 'content': text});
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Authorization': 'Bearer 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}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': '${text}',
        'max_tokens': 200,
      }),
    );

    final data = jsonDecode(response.body);

    setState(() {
      _messages.insert(0, {'role': 'bot', 'content': data['choices'][0]['text']});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('Chat with AI')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  leading: message['role'] == 'bot'
                      ? Icon(Icons.cloud_queue)
                      : Icon(Icons.account_circle),
                  title: Text(
                    message['content'],
                    style: TextStyle(
                      color: message['role'] == 'bot' ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(10), child : Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                await _sendMessage(_controller.text);
                _controller.clear();
                },
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}