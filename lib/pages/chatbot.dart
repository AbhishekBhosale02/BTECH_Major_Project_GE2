import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:sih_23_audiometer/pages/Messages.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 191, 72, 9),
        hintColor: Color.fromARGB(255, 76, 219, 24),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('KarnBot', style: TextStyle(fontSize: 18)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: MessagesScreen(messages: messages)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Color.fromARGB(255, 2, 3, 20)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 53, 161, 160),
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send, color: Color.fromARGB(255, 25, 74, 190)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );

      if (response.message == null) {
        print('Error in processing response');
        return;
      }

      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      // Add different colors for questions and answers
      messages.add({'message': message, 'isUserMessage': isUserMessage, 'color': isUserMessage ? Colors.blue : Colors.green});
    });
  }
}
