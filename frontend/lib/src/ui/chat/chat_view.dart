import 'package:flutter/material.dart';
import 'package:jober/src/ui/chat/chat_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);
  static const routeName = "/chat";
  final ChatViewModel _viewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _viewModel.jobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${AppLocalizations.of(context)!.job} $index - ${_viewModel.jobs[index].title}"),
            subtitle: Center(child: Text(AppLocalizations.of(context)!.waitingForAnswer),),
          );
        },
      ),
    );
  }
}
