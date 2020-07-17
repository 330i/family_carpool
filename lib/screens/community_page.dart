import 'dart:convert';
import 'dart:io';

import 'package:family_carpool/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class CommunityPage extends StatefulWidget {



  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  bool loaded = false;

  String baseaddr = "http://192.168.0.12:8080/";

  Future<String> getCurUser() async {
    String val = "";

    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/language.txt');
      String temp = await file.readAsString();
      val = temp;
    } catch (e) {
      print("Couldn't read file");
    }
    return val;
  }

  @override
  void initState(){
    super.initState();

    getRoutes();
    newFriendController = new TextEditingController();
  }



  List<Widget> chats = [];

  List<String> friendnames = [];

  Future getRoutes() async {
    //Route Data Receive Here
    var username = await getCurUser();

    var h = await http.get(baseaddr + "routes/name/" + username);



    print(h.body.toString());
    for (var data in json.decode(h.body)) {
      print(data);
      setState(() {
        chats.add(getContainer(json.decode(data['routedata'])['title'],
            json.decode(data['addresses'])[json
                .decode(data['addresses'])
                .length-1],
            'https://i.thecartoonist.me/cartoon-face-of-white-male.png',
        data['id'].toString(), false));
      });
    }

    setState(() {
      loaded = true;
    });

    await getFriends();
  }

  var userJson;
  BuildContext cont;


  List<Widget> friends = [];

  Future getFriends() async {
    //Route Data Receive Here
    var username = await getCurUser();

    print("USERNAME"+username);
    var h = await http.get(baseaddr + "users/byname/" + username);

    print(h.body.toString());

    userJson = json.decode(h.body);


    for (String friend in json.decode(userJson['friends'])) {
      setState(() {
        friends.add(getContainer(friend, "",
            'https://i.thecartoonist.me/cartoon-face-of-white-male.png', '', true));
        friendnames.add(friend);
      });
    }

    setState(() {
      loaded = true;
    });
  }

  Future addFriend(String friend) async {
    friendnames.add(friend);
    print(friendnames.toString());
    print(baseaddr + "users/update/" + userJson['id'].toString() + "/" + userJson['name'] +
        "/" + userJson['password'] + "/" + userJson['lat'].toString() +
        "/" + userJson['userdata'] + "/" +
        json.encode(friendnames).toString());
    await http.get(
        baseaddr + "users/update/" + userJson['id'].toString() + "/" + userJson['name'] +
            "/" + userJson['password'] + "/" + userJson['lat'].toString() +"/"+userJson['lng'].toString()+
            "/" + userJson['userdata'] + "/" +
            json.encode(friendnames).toString());
  }

  TextEditingController newFriendController;

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: newFriendController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Username of Trusted Friend', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () async{
                await addFriend(newFriendController.text.toString());
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  Widget getContainer(String name, String address, String image, String id, bool user) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 15),
      child: GestureDetector(
        onTap: (){
          if(!user)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(chatId: id,user: userJson['name'],)),
            );
        },
        child: Container(
          width: 450.0,
          height: 70.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
                bottomLeft: const Radius.circular(25.0),
                bottomRight: const Radius.circular(25.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Row(children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.0, right: 7.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: 40.0,
                  height: 55.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          alignment: Alignment.bottomLeft,
                          fit: BoxFit.fill,
                          image: new NetworkImage(image)))),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 25.0,
                ),
              ),
            ),
            SizedBox(
              width: 80.0,
            ),
            IconButton(
              icon: Icon(
                Icons.map,
                color: Colors.pink,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cont = context;
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Community CarPools",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: _theme.primaryColor,
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: _theme.primaryColor,
                      tabs: <Widget>[
                        Tab(
                          text: "Group Chats",
                        ),
                        Tab(
                          text: "Friends",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: chats.length,

                            itemBuilder: ((context, i) {

                              return chats[i];


                            }),

                          ),
                          Container(
                            child: ListView.builder(
                              itemCount: friends.length,
                              itemBuilder: ((context, i) {
                                return friends[i];
                              }),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}