part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  bool isLoading = false;
  String email = "";
  String userName = "";
  String avatar = "";

  Future<void> getUser() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).get().then((value) {
      setState(() {
        userName = value['name'].toString();
        email = auth.currentUser.email;
        avatar = value['avatar'].toString();
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Setting.routeName);
                },
                child: Icon(Icons.settings),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // margin: EdgeInsets.all(16),
          child: Stack(children: [
            ListView(children: [
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text(
                  "Signed is as...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditProfile.routeName);
                },
                child: Card(
                  margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 16, 0, 16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 24.0,
                            backgroundImage: NetworkImage(avatar),
                          ),
                          // Image.asset("assets/images/tv.png", height: 100),
                          title: Text(
                            userName,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            softWrap: true,
                          ),
                          subtitle: Text(
                            email,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            softWrap: true,
                          ),
                          trailing: IconButton(
                            icon: Icon(CupertinoIcons.play_arrow),
                            color: Colors.grey,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ));
  }
}
