import 'package:flutter/material.dart';
import 'package:job_finder/core/functions/route.dart';
import 'package:job_finder/core/utils/colors.dart';
import 'package:job_finder/features/jobSeeker/chats/chat.dart';

class messages extends StatefulWidget {
  const messages({super.key});

  @override
  State<messages> createState() => _messagesState();
}

class _messagesState extends State<messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.white,
              backgroundImage: AssetImage('assets/icons/profile.png'),
            ),
            title: Text('amani'),
            subtitle: Text('hi'),
            trailing: Text(
              '4pm',
              // _formatTimestamp(lastMessage.timestamp),
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              push(context, chat());
              // Navigate to the chat screen for the selected user
              // You can implement this based on your navigation logic
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(user: user)));
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed (e.g., "2 hours ago")
    // You can use a library like `intl` for more sophisticated formatting
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
