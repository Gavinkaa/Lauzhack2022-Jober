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
            return ListView.builder(
              itemCount: _viewModel.getJobs().length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: _viewModel.getJobs()[index].imageUrl.contains("assets")
                            ? AssetImage(_viewModel.getJobs()[index].imageUrl) as ImageProvider
                            : NetworkImage(_viewModel.getJobs()[index].imageUrl),

                      ),
                      title: Text(_viewModel.getJobs()[index].name),
                      trailing: const Icon(Icons.alarm, color: Colors.orange,),
                      subtitle: Text(_viewModel.getJobs()[index].description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    )
                  ],
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
