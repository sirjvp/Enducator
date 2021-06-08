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

  bool isLoading = false;
  bool exist = false;
  String uid = auth.currentUser.uid;
  double totalWatt = 0;
  double totalPay = 0;
  double total = 0;
  int currency = 0;
  String showTotal = "-";
  int count = 0;
  String rid = "";

  Future<void> getPay() async {
    double pay = 0;
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
    isExist();
  }
   
  Future<void> totalKWh() async {
    double watt = 0;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("devices").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        watt += doc['deviceWatt'] * doc['deviceQuantity'] * doc['deviceTime'] * doc['deviceDay'];
        count++;
      });
    });
    totalWatt = watt / 1000;
    total = totalWatt * totalPay;
    if(currency == 2){
      showTotal = ActivityServices.toUS(total.toString());
    }else{
      showTotal = ActivityServices.toIDR(total.toString());
    }
    setState(() {
      
    });
  }

  Future<void> isExist() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("reports").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(doc.data()['time'] == ActivityServices.monthNow()){
          exist = true;
          rid = doc.data()['reportId'];
        }
      });
    });
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
              totalPay.toString(),
              currency.toString(),
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

  void dialogBox(BuildContext ctx, Calculate calculate){
    showDialog(
      context: ctx,
      builder: (ctx){
        String rid = calculate.reportId;
        int count = calculate.totalDevice;
        double totalWatt = calculate.totalWatt;
        double price = calculate.price;
        String time = calculate.time;
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Do you want to save your report?"),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  Calculate calculate = Calculate(rid, count, totalWatt, price, time, "", "");
                  if(exist == false){
                    await CalculateServices.addReport(calculate).then((value){
                      if(value == true){
                        ActivityServices.showToast("Save report sucessfull!", Colors.green);
                        Navigator.pop(context);
                      }else{
                        ActivityServices.showToast("Save report failed!", Colors.red);
                      }
                    });
                  }else{
                    await CalculateServices.updateReport(calculate).then((value){
                      if(value == true){
                        ActivityServices.showToast("Update report sucessfull!", Colors.green);
                        Navigator.pop(context);
                      }else{
                        ActivityServices.showToast("update report failed!", Colors.red);
                      }
                    });
                  }
                },
                child: Text(
                        "Yes",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text(
                        "No",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
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
          title: Text("Report", style: TextStyle(color: Colors.white)),
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
                      Calculate calculate = Calculate(rid, count, totalWatt, total, ActivityServices.monthNow(), "", "");
                      dialogBox(context, calculate);
                      // Navigator.pushNamed(context, ReportDetail.routeName, arguments: calculate);
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
                  Container(
                    height: 430,
                    width: double.infinity,
                    child: Stack(children: [buildBody()])
                  ),
                ]
              ),
            ),
          ]),
        ));
  }
}
