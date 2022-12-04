import 'package:flutter/material.dart';
import 'package:jober/src/ui/chat/chat_view_model.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key}) : super(key: key);
  static const routeName = "/chat";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatViewModel _viewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _viewModel.fetchJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("YOOOO");
            print(_viewModel.getJobs().length);
            return ListView.builder(
              itemCount: _viewModel.getJobs().length,
              itemBuilder: (context, index) {
                print("${_viewModel.getJobs()[index]}\n");
                return ListTile(
                  title: Text(_viewModel.getJobs()[index].name),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }


}
