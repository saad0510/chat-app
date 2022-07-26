import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../states/controllers_state.dart';
import '../states/helpers/user_friends_state.dart';
import 'auth_screen.dart';
import 'chat_screen.dart';
import 'search_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool navigationLock = false;

    void signout() async {
      Navigator.pushReplacementNamed(context, AuthScreen.route);
      await ref.read(providerOfAuthController.notifier).signout();
    }

    Future<void> gotoChat(UserModel friend) async {
      if (navigationLock) return;

      navigationLock = true;
      await ref.read(providerOfChatController.notifier).startChatWith(friend.uid);
      navigationLock = false;

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ChatScreen.route, arguments: friend);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: signout,
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, SearchScreen.route),
        child: const Icon(Icons.search),
      ),
      body: ref.watch(providerOfUserFriends).when(
            data: (friends) {
              if (friends == null || friends.isEmpty) {
                return const Center(
                  child: Text("No friends to show"),
                );
              }
              return ListView.builder(
                itemCount: friends.length,
                itemBuilder: (_, i) {
                  final friend = friends[i].user;
                  final crid = friends[i].crid;

                  final lastMsgStream = ref.watch(providerOfLastMsg(crid));

                  return GestureDetector(
                    onTap: () => gotoChat(friend),
                    child: ListTile(
                      title: Text(
                        friend.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: lastMsgStream.when(
                        data: (lastMsg) => Text(
                          lastMsg.content,
                          overflow: TextOverflow.ellipsis,
                        ),
                        error: (err, _) => const Text(""),
                        loading: () => const Text("Loading..."),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.8),
                        backgroundImage: NetworkImage(friend.image),
                        onBackgroundImageError: (_, __) {},
                      ),
                      trailing: lastMsgStream.when(
                        data: (lastMsg) => Text(
                          DateTime.fromMillisecondsSinceEpoch(lastMsg.timestamp)
                              .toAdaptiveString,
                        ),
                        error: (err, _) => const Text(""),
                        loading: () => const Text("Loading"),
                      ),
                    ),
                  );
                },
              );
            },
            error: (err, _) => Center(child: Text("$err")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

extension AdpativeMessageTime on DateTime {
  String get toAdaptiveString {
    int relativeTime =
        DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch;
    const dayinMilliseconds = 24 * 60 * 60 * 1000;
    if (relativeTime < dayinMilliseconds) {
      return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    } else if (relativeTime < dayinMilliseconds * 2) {
      return "Yesterday";
    }
    return "$day/$month/$year";
  }
}
