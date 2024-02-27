import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:job_finder/core/utils/colors.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatView(
        appBar: ChatViewAppBar(
          elevation: 1,
          backGroundColor: Colors.transparent,
          //profilePicture: Data.profileImage,
          backArrowColor: AppColors.primary,
          chatTitle: "amani",

          chatTitleTextStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.25,
          ),
          userStatus: "online",
          userStatusTextStyle: const TextStyle(color: Colors.green),
          // actions: [
          //   IconButton(
          //     onPressed: _onThemeIconTap,
          //     icon: Icon(
          //       isDarkTheme
          //           ? Icons.brightness_4_outlined
          //           : Icons.dark_mode_outlined,
          //       color: theme.themeIconColor,
          //     ),
          //   ),
          //   IconButton(
          //     tooltip: 'Toggle TypingIndicator',
          //     onPressed: _showHideTypingIndicator,
          //     icon: Icon(
          //       Icons.keyboard,
          //       color: theme.themeIconColor,
          //     ),
          //   ),
          //  ],
        ),
        currentUser: ChatUser(
          id: '1',
          name: 'Your Name',
          profilePhoto: 'path/to/your_profile_image.jpg',
        ),
        chatController: ChatController(
          initialMessageList: [
            Message(
              id: '1',
              createdAt: DateTime.now().subtract(Duration(minutes: 15)),
              message: 'Hello there!',
              sendBy: '2', // Sender's ID (should match ChatUser ID)
            ),
            Message(
              id: '2',
              createdAt: DateTime.now().subtract(Duration(minutes: 10)),
              message: 'Hi! How are you?',
              sendBy: '1', // Sender's ID (should match ChatUser ID)
            ),
          ], // Provide your initial list of messages
          scrollController: ScrollController(),
          chatUsers: [
            ChatUser(
              id: '2',
              name: 'Friend 1',
              // profilePhoto: 'path/to/friend1_profile_image.jpg',
            ),
            // Add more ChatUser objects for additional users
          ],
        ),
        onSendTap: (String message, ReplyMessage replyMessage,
            MessageType messageType) {
          // Handle sending a message
        },
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: Colors.blue[100],
              bodyStyle: TextStyle(
                color: Colors.blue[900],
              ),
              titleStyle: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.blue[400],
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: Colors.grey[200],
              bodyStyle: TextStyle(
                color: Colors.grey[800],
              ),
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            textStyle: TextStyle(color: Colors.black),
            senderNameTextStyle: TextStyle(color: Colors.blue[700]),
            color: Colors.grey[300],
          ),
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: Colors.grey,
          messageTimeTextStyle: TextStyle(color: Colors.grey),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: Colors.blue,
              fontSize: 17,
            ),
          ),
          backgroundColor: Colors.grey[100],
        ),
        sendMessageConfig: SendMessageConfiguration(
          replyMessageColor: Colors.blue[100],
          defaultSendButtonColor: Colors.blue,
          replyDialogColor: Colors.blue[100],
          replyTitleColor: Colors.blue[700],
          textFieldBackgroundColor: Colors.white,
          textFieldConfig: TextFieldConfiguration(
            textStyle: TextStyle(color: Colors.black),
          ),
          voiceRecordingConfiguration: VoiceRecordingConfiguration(
            backgroundColor: Colors.blue[100],
            recorderIconColor: Colors.blue[700],
            waveStyle: WaveStyle(
              showMiddleLine: false,
              waveColor: Colors.blue,
              extendWaveform: true,
            ),
          ),
        ),
        chatViewState: ChatViewState.hasMessages,
      ),
    );
  }
}
