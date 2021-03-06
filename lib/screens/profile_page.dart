import 'dart:convert';
import 'dart:io';

import 'package:family_carpool/utils/requestconvert.dart';
import 'package:flutter/material.dart';
import 'package:family_carpool/themes/colors.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:simple_gravatar/simple_gravatar.dart';


class ProfilePage extends StatefulWidget {

  final String user;

  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();


}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    getIP();
    super.initState();
  }
  final color = LightColors.kDarkYellow;
  
  dynamic userdata;
  String baseaddr;


  Future getIP()async{

    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/ip.txt');
      String temp = await file.readAsString();
      setState(() {
        baseaddr = temp;
      });
      print(temp);
    } catch (e) {
      print("Couldn't read file");
    }

    await getUserData();
  }


  String loadGravatar(String uname){
    var gravatar = Gravatar(uname);
    String gravurl = gravatar.imageUrl(
      size: 100,
      defaultImage: GravatarImage.retro,
      rating: GravatarRating.pg,
      fileExtension: true,
    );
    return gravurl;
  }

  Future getUserData() async{
    print("STARTED GETTING DATA");
    var h = await http.get(baseaddr + "users/byname/" + widget.user);
    
    userdata = json.decode(h.body);

    print(userdata);
    setState(() {
      loaded = true;
    });
  }

  bool loaded = false;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 1.8;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,
        title: Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: loaded?Column(
        children: <Widget>[
          buildTop(height, width),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      json.decode(RequestConvert.convertFrom(userdata['userdata']))['description']),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  title:
                  Text(json.decode(RequestConvert.convertFrom(userdata['userdata']))['email']),
                ),
              ],
            ),
          ),
        ],
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildTop(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: height * 0.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Age',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        json.decode(RequestConvert.convertFrom(userdata['userdata']))['age'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                loadGravatar(userdata['name'])),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'ID: '+userdata['id'].toString(),
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Years Driving",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        json.decode(RequestConvert.convertFrom(userdata['userdata']))['years'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              userdata['name'],
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildOption(Icons.group_add, "Friends", true),
                buildOption(Icons.group, "Carpools", true),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }


  Widget buildOption(IconData icon, String text, bool top) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Icon(
            icon,
            size: 37.0,
            color: top ? Colors.white : Colors.grey,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 15.0,
            color: top ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}