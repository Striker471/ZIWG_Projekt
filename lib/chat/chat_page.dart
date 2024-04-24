import 'package:flutter/material.dart';
import 'package:health_care_app/chat/components/chat_bubble.dart';
import 'messagees_global.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> chat = messages;

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        chat.add({
          'isUserMessage': true,
          'message': _messageController.text,
          'dateTime': DateTime.now().toIso8601String()
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chat Bot")),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(chat),
            ),
            _buildUserInput(context)
          ],
        ));
  }

  Widget _buildMessageList(List<Map<String, dynamic>> chat) {
    return ListView.builder(
      itemCount: chat.length,
      itemBuilder: (context, index) {
        var message = chat[index];
        return _buildMessageItem(message);
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    bool isCurrentUser = data["isUserMessage"];
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
            ]));
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          Container(
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.arrow_upward),
                  color: Colors.white)),
        ],
      ),
    );
  }
}
