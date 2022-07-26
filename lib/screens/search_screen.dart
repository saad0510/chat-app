import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/helpers/search_users_state.dart';
import '../widgets/search_result.dart';
import '../widgets/search_users_field.dart';
import '../models/user_model.dart';
import '../states/controllers_state.dart';
import 'chat_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const route = "/search";

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String searchKey = "";
  bool navigationLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: SearchUsersField(
          onChanged: (val) {
            if (val.trim().isEmpty) return;
            setState(() => searchKey = val);
          },
        ),
      ),
      body: ref.watch(providerOfSearchUsers(searchKey)).when(
            data: (users) => users.isEmpty
                ? const Center(
                    child: Text("No users found"),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, i) => SearchResult(
                      user: users[i],
                      onMessage: () => gotoChat(users[i]),
                    ),
                  ),
            error: (err, _) => Center(child: Text("$err")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }

  Future<void> gotoChat(UserModel friend) async {
    if (navigationLock) return;

    navigationLock = true;
    await ref.read(providerOfChatController.notifier).startChatWith(friend.uid);
    navigationLock = false;

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, ChatScreen.route, arguments: friend);
  }
}
