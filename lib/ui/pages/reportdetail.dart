part of 'pages.dart';

class ReportDetail extends StatefulWidget {
  static const String routeName = "/reportdetail";

  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference userDoc;

  String uid = auth.currentUser.uid;

  bool isLoading = false;
  bool exist = false;
  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlWatt = TextEditingController();
  final ctrlQuantity = TextEditingController();
  final ctrlDay = TextEditingController();
  final ctrlTime = TextEditingController();
  String deviceId = "";

  double totalWatt = 0;
  double price = 0;
  int count = 0;
  String time = "";
  String rid = "";

  Future<void> isExist() async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    await userCollection.doc(uid).collection("reports").get().then((QuerySnapshot querySnapshot) {
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
        child: StreamBuilder<QuerySnapshot>(
      stream: userCollection
          .doc(uid)
          .collection("devices")
          .where('addBy', isEqualTo: uid)
          .orderBy("deviceWatt", descending: true)
          .limit(3)
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
    isExist();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    Calculate calculate = ModalRoute.of(context).settings.arguments;
    totalWatt = calculate.totalWatt;
    price = calculate.price;
    time = calculate.time;
    count = calculate.totalDevice;

    // ctrlName.text = devices.deviceName;
    // ctrlWatt.text = devices.deviceWatt.toString();
    // ctrlQuantity.text = devices.deviceQuantity.toString();
    // ctrlDay.text = devices.deviceDay.toString();
    // ctrlTime.text = devices.deviceTime.toString();
    // deviceId = devices.deviceId;
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // buildBody(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: [
                      SizedBox(height: 24),
                      // buildBody()
                      ]
                  )
                ),
                ListView(padding: EdgeInsets.all(16), children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                                Calculate calculate = Calculate(rid, count, totalWatt, price, time, "", "");
                                if(exist == false){
                                  await CalculateServices.addReport(calculate).then((value){
                                    if(value == true){
                                      ActivityServices.showToast("Save report sucessfull!", Colors.green);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }else{
                                      ActivityServices.showToast("Save report failed!", Colors.red);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                }else{
                                  await CalculateServices.updateReport(calculate).then((value){
                                    if(value == true){
                                      ActivityServices.showToast("Update report sucessfull!", Colors.green);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }else{
                                      ActivityServices.showToast("update report failed!", Colors.red);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                }
                                
                              }else{
                                ActivityServices.showToast("Please check form fields!", Colors.red);
                              }
                            },
                            icon: Icon(Icons.save),
                            label: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.lightTheme().primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                            )
                          ),
                        ],
                      )),
                ]),
                // isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}