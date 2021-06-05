part of 'pages.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference deviceCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference userDoc;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String uid = auth.currentUser.uid;
  double totalWatt = 0;
  int totalPay = 0;
  double total = 0;
  int currency = 0;
  String showTotal = "-";
  int count = 0;

  Future<void> getPay() async {
    int pay = 0;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    if(deviceCollection != null){
      await deviceCollection.doc(uid).get().then((value) {
        pay = value['modal'];
        currency = value['currency'];
      });
      totalPay = pay;
    }
    totalKWh();
  }
   
  Future<void> totalKWh() async {
    int watt = 0;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("devices").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        watt += doc['deviceWatt'] * doc['deviceQuantity'] * doc['deviceTime'] * doc['deviceDay'];
        count++;
      });
    });
    totalWatt = watt.toDouble() / 1000;
    total = totalWatt * totalPay.toDouble();
    if(currency == 2){
      showTotal = ActivityServices.toUS(total.toString());
    }else{
      showTotal = ActivityServices.toIDR(total.toString());
    }
    setState(() {
      
    });
  }

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
      stream: deviceCollection
          .doc(uid)
          .collection("devices")
          .where('addBy', isEqualTo: uid)
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
            Devices devices = new Devices(
              doc.data()['deviceId'],
              doc.data()['deviceName'],
              doc.data()['deviceWatt'],
              doc.data()['deviceQuantity'],
              doc.data()['deviceDay'],
              doc.data()['deviceTime'],
              doc.data()['deviceImage'],
              doc.data()['addBy'],
              doc.data()['devicecreatedAt'],
              doc.data()['deviceupdatedAt'],
            );
            return CardView(devices: devices);
          }).toList(),
        );
      },
    ));
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    getPay();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
    setState(() {
      
    });
  }

  @override
  void initState(){
    getPay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("REPORT", style: TextStyle(color: Colors.white)),
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
        ),
        resizeToAvoidBottomInset: false,
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
                  GestureDetector(
                    onTap: () {
                      Calculate calculate = Calculate("", count, totalWatt, total, ActivityServices.monthNow(), "", "");
                      Navigator.pushNamed(context, ReportDetail.routeName, arguments: calculate);
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(16, 32, 16, 16),
                      elevation: 1,
                      color: MyTheme.lightTheme().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 0, 16),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: Text(
                                ActivityServices.monthNow(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                            SizedBox(height: 24),
                            ListTile(
                              title: Text(
                                "Electricity Usage",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                softWrap: true,
                              ),
                              subtitle: Text(
                                totalWatt.toString() + " kWh",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  showTotal,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Stack(children: [buildBody()])
            ),
          ]),
        ));
  }
}
