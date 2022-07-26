import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class SearchResult extends ConsumerWidget {
  const SearchResult({
    Key? key,
    required this.user,
    required this.onMessage,
  }) : super(key: key);

  final UserModel user;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        user.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        user.email,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(0.8),
        backgroundImage: NetworkImage(user.image),
        onBackgroundImageError: (_, __) {},
      ),
      trailing: IconButton(
        onPressed: onMessage,
        icon: const Icon(Icons.message),
      ),
    );
  }
}
