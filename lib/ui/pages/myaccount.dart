part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String uid = auth.currentUser.uid;
  bool isLoading = false;
  bool refresh = false;
  bool exist = false;
  bool logout = false;
  String email = "";
  String userName = "";
  String avatar = "";
  String phone = "";
  String password = "";
  int currency = 1;

  Future<void> getUser() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).get().then((value) {
      setState(() {
        userName = value['name'];
        email = auth.currentUser.email;
        avatar = value['avatar'];
        phone = value['phone'];
        password = value['password'];
        currency = value['currency'];
      });
    });
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    getUser();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
    setState(() {
      
    });
  }

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
              currency.toString(),
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
          title: Text("My Account", style: TextStyle(color: Colors.white)),
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Setting.routeName).then((logout) => setState(() {
                    if(logout == true){
                      Navigator.pushReplacementNamed(context, Login.routeName);
                    }
                  }));
                },
                child: Icon(
                        Icons.settings,
                        color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus mode){
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("pull up load");
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("Load Failed!Click retry!");
                  }
                  else if(mode == LoadStatus.canLoading){
                      body = Text("release to load more");
                  }
                  else{
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: 
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
                      Users users = new Users("", userName, phone, email, password, avatar, 0, 1, "", "");
                      Navigator.pushNamed(context, EditProfile.routeName, arguments: users).then((value) => setState(() {getUser();}));
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
                                trailing: 
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Colors.grey[400],
                                  ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
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
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    height: 455,
                    width: double.infinity,
                    child: Stack(children: [buildBody()])
                  ),
                ]),
            ),
          ]),
        ));
  }
}
