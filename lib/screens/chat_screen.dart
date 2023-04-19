import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_chat/models/message_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final _controller = ScrollController();
  static String chatRoute = 'chatRoute';
  bool isLoading = false;
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromSnapshot(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kLogo, height: 50),
                    const Text('Meta Chatter'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBubble(
                                  message: messageList[index],
                                )
                              : ChatBubleForFriend(message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textController,
                      onSubmitted: (data) => {
                        messages.add({kMessage: data, kCreatedAt: DateTime.now(), kId: email}),
                        textController.clear(),
                        _controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        )
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: kPrimaryColor!)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const ModalProgressHUD(
              inAsyncCall: true,
              child: Scaffold(),
            );
          }
        });
  }
}
