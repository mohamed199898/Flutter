import 'package:bus_station/Src/Service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'general_user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _editingController = TextEditingController();
  String name = 'Write your name...';
  String messege = "Write message...";
  String pro = 'unknown';
  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(pro),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/pn.jpg"),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('1234')
                      .orderBy('Time')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('error');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('empty');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return LinearProgressIndicator();
                    }

                    List<DocumentSnapshot> _docs = snapshot.data!.docs;

                    List<GeneralUser> messages = _docs
                        .map((e) => GeneralUser.fromMap(
                            e.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 5, top: 5, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        messages[index].chat ?? 'no chat',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      messages[index].date == null
                                          ? Container()
                                          : Text(
                                              messages[index]
                                                  .date!
                                                  .toDate()
                                                  .minute
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      decoration: InputDecoration(
                          hintText: name,
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      setState(() async {
                        if (name == 'Write your name...') {
                          pro = _chatController.value.text;
                          _chatController.clear();
                          name = messege;
                        } else {
                          await FirebaseFirestore.instance
                              .collection('1234')
                              .add({
                            'chat': _chatController.value.text,
                            'Time': Timestamp.now(),
                          });
                          _chatController.clear();
                        }
                      });

                      //     .collection('users')
                      //     .add({
                      //   'name': "wha",
                      //   'email': 00121212,
                      //   'bootCampId': "whad",
                      // }).catchError((e) => debugPrint(e.toString()));
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
}
