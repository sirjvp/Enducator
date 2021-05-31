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

  String uid = auth.currentUser.uid;
  double totalWatt = 0;
  int totalPay = 0;
  double total = 0;

  Future<void> getPay() async {
    int pay = 0;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).get().then((value) {
      setState(() {
        pay = value['modal'];
      });
    });
    totalPay = pay;
  }
   
  Future<void> totalKWh() async {
    int watt = 0;
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await deviceCollection.doc(uid).collection("devices").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        watt += doc['deviceWatt'] * doc['deviceQuantity'] * doc['deviceTime'] * doc['deviceDay'];
      });
    });
    setState(() {
      totalWatt = watt.toDouble() / 1000;
      total = totalWatt * totalPay.toDouble();
    });
  }

  Widget buildBody() {
    return Container(
        // width: double.infinity,
        // height: double.infinity,
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

  @override
  void initState(){
    getPay();
    totalKWh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Report"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // margin: EdgeInsets.all(16),
          child: Stack(children: [
            ListView(children: [
              Card(
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
                          // ActivityServices.toIDR(device.devicePrice),
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
                          // ActivityServices.toIDR(device.devicePrice),
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
                            "Rp. " + total.toString(),
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
            ]),
            Container(
                padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Stack(children: [buildBody()]))
          ]),
        ));
  }
}
