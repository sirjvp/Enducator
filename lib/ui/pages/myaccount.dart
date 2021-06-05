part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  String uid = auth.currentUser.uid;

  bool isLoading = false;
  bool refresh = false;
  bool exist = false;
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

  // Future<void> isExist() async {
  //   await Firebase.initializeApp();
  //   String uid = auth.currentUser.uid;
  //   await userCollection.doc(uid).collection("reports").get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       if(doc.data() != null){
  //         exist = true;
  //       }
  //     });
  //   });
  //   setState(() {
      
  //   });
  // }

  Widget buildBody() {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: userCollection
          .doc(uid)
          .collection("reports")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Failed to load data!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ActivityServices.loadings();
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot doc) {
            Calculate calculate = new Calculate(
              doc.data()['reportId'],
              doc.data()['totalDevice'],
              doc.data()['totalWatt'],
              doc.data()['price'],
              doc.data()['time'],
              doc.data()['createdAt'],
              doc.data()['updatedAt'],
            );
            return ReportCard(calculate: calculate);
          }).toList(),
        );
      },
    ));
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
          title: Text("MY ACCOUNT", style: TextStyle(color: Colors.white)),
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
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
                  // Route route = MaterialPageRoute(builder: (context) => EditProfile());
                  Navigator.pushNamed(context, EditProfile.routeName).then((value) => setState(() {getUser();}));
                },
                child: 
                  Card(
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
            Container(
                padding: EdgeInsets.fromLTRB(24, 210, 0, 0),
                child: Text(
                  "History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Stack(children: [buildBody()]))
          ]),
        ));
  }
}
