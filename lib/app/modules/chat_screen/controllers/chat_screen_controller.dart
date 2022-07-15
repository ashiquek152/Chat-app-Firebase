import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  // final count = 0.obs;

  ChatScreenController({this.chatRoomId});
  final chatRoomId;

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void initState() {
    // getMessagesIncontroller();
    super.onInit();
  }

  // void increment() => count.value++;
  final currentUser = FirebaseAuth.instance.currentUser;

  final RxBool _showEmojiPicker = false.obs;
  RxBool get showEmojiPicker => _showEmojiPicker;
  Stream? chatMessagesStream;

  toggleEmojiPicker() {
    _showEmojiPicker.value = !_showEmojiPicker.value;
    update();
  }

  final List messages = [];
  getMessages(chatRoomid) async {
    // messages.clear();
   return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomid)
        .collection("chats")
        .where("messege")
        .get()
        .then((value) {
      value.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String, dynamic>;
        messages.add(a);
      }).toList();
    update();
    });
  }
}


// class ChatList extends StatelessWidget {
//    const ChatList({Key? key,required this.chatMessagesStream}) : super(key: key);

//   final Stream? chatMessagesStream;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: chatMessagesStream,
//       builder: (context, snapshot) {
//       return ListView.builder(
//         itemCount: 10, 
//         itemBuilder: (context, index) {
//         return ChatBubble(chatFieldController: chatFieldController,message: snapshot.data.document[index].data.["message"],);
//       },);
//     },);
//   }
// }
