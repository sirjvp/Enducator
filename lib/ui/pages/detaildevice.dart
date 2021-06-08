part of 'pages.dart';

class DetailDevice extends StatefulWidget {
  static const String routeName = "/detaildevice";

  @override
  _DetailDeviceState createState() => _DetailDeviceState();
}

class _DetailDeviceState extends State<DetailDevice> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  bool isLoading = false;
  bool isClicked = false;
  final ctrlName = TextEditingController();
  final ctrlWatt = TextEditingController();
  final ctrlQuantity = TextEditingController();
  final ctrlDay = TextEditingController();
  final ctrlTime = TextEditingController();
  int ctrlImage = 1;
  String deviceId = "";
  String edit = "";

  void dialogWatt(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlWatt,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });             
                  Devices devices = Devices(deviceId, ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), double.parse(ctrlTime.text), ctrlImage.toString(), FirebaseAuth.instance.currentUser.uid, "", "");
                  await DeviceServices.updateDevice(devices).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save device sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save device failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
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
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogQuantity(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlQuantity,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });             
                  Devices devices = Devices(deviceId, ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), double.parse(ctrlTime.text), ctrlImage.toString(), FirebaseAuth.instance.currentUser.uid, "", "");
                  await DeviceServices.updateDevice(devices).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save device sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save device failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
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
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogDay(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlDay,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });             
                  Devices devices = Devices(deviceId, ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), double.parse(ctrlTime.text), ctrlImage.toString(), FirebaseAuth.instance.currentUser.uid, "", "");
                  await DeviceServices.updateDevice(devices).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save device sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save device failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
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
                child:
                  Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void dialogTime(BuildContext ctx, String edit){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text(edit, textAlign: TextAlign.center),
          content: TextFormField(
                    controller: ctrlTime,
                    keyboardType: TextInputType.number,
                    autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill the field!";
                      } else {
                        return null;
                      }
                    },
                  ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  setState(() {
                  isLoading = true;
                  });             
                  Devices devices = Devices(deviceId, ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), double.parse(ctrlTime.text), ctrlImage.toString(), FirebaseAuth.instance.currentUser.uid, "", "");
                  await DeviceServices.updateDevice(devices).then((value){
                    if(value == "success"){
                      ActivityServices.showToast("Save device sucessfull!", Colors.green);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else{
                      ActivityServices.showToast("Save device failed!", Colors.red);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
                child: 
                  Text(
                    "Save",
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
                child:
                  Text(
                    "Cancel",
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Devices devices = ModalRoute.of(context).settings.arguments;
    ctrlName.text = devices.deviceName;
    ctrlWatt.text = devices.deviceWatt.toString();
    ctrlQuantity.text = devices.deviceQuantity.toString();
    ctrlDay.text = devices.deviceDay.toString();
    ctrlTime.text = devices.deviceTime.toString();
    if(isClicked == false){
      ctrlImage = int.parse(devices.deviceImage);
    }
    deviceId = devices.deviceId;

    double hour = devices.deviceWatt / 1000 * devices.deviceQuantity;
    double day = hour * devices.deviceTime;
    double month = day * devices.deviceDay;
    double year = month * 12;
    double hour2 = hour * double.parse(devices.addBy);
    double day2 = hour2 * devices.deviceTime;
    double month2 = day2 * devices.deviceDay;
    double year2 = month2 * 12;

    String showHour = "";
    String showDay = "";
    String showMonth = "";
    String showYear = "";

    if(devices.createdAt == "2"){
      showHour = ActivityServices.toUS(hour2.toString());
      showDay = ActivityServices.toUS(day2.toString());
      showMonth = ActivityServices.toUS(month2.toString());
      showYear = ActivityServices.toUS(year2.toString());
    }else{
      showHour = ActivityServices.toIDR(hour2.toString());
      showDay = ActivityServices.toIDR(day2.toString());
      showMonth = ActivityServices.toIDR(month2.toString());
      showYear = ActivityServices.toIDR(year2.toString());
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(ctrlName.text, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          )
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      child: Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                edit = "Edit Watt";
                                dialogWatt(context, edit);
                              },
                              child:
                                ListTile(
                                  leading: Text(
                                    "Watt",
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                        ctrlWatt.text,
                                        style: TextStyle(
                                            fontSize: 17, fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                        softWrap: true,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    )
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  edit = "Edit Quantity";
                                  dialogQuantity(context, edit);
                                },
                                child:
                                  ListTile(
                                    leading: Text(
                                      "Quantity",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                        ctrlQuantity.text,
                                        style: TextStyle(
                                            fontSize: 17, fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                        softWrap: true,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    )
                                  ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    Card(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  edit = "Edit Day Usage";
                                  dialogDay(context, edit);
                                },
                                child:
                                  ListTile(
                                    leading: Text(
                                      "Day Usage",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                        ctrlDay.text,
                                        style: TextStyle(
                                            fontSize: 17, fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                        softWrap: true,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    )
                                  ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    Card(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  edit = "Edit Hour Usage";
                                  dialogTime(context, edit);
                                },
                                child:
                                  ListTile(
                                    leading: Text(
                                      "Hour Usage",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                        ctrlTime.text,
                                        style: TextStyle(
                                            fontSize: 17, fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                        softWrap: true,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            color: Colors.orange,
                            child: 
                              Column(
                                children: [
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SizedBox(width: 30),
                                      Text(
                                        "Hourly Cost",
                                        style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    hour.toStringAsFixed(3) + "kWh",
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  Text(
                                    showHour,
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ]
                              ),
                          ),
                          Card(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            color: Colors.blue,
                            child: 
                              Column(
                                children: [
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SizedBox(width: 35),
                                      Text(
                                        "Daily Cost",
                                        style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 35),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    day.toStringAsFixed(2) + "kWh",
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  Text(
                                    showDay,
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ]
                              ),
                          ),
                          Card(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            color: Colors.green,
                            child: 
                              Column(
                                children: [
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SizedBox(width: 24),
                                      Text(
                                        "Monthly Cost",
                                        style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 24),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    month.toStringAsFixed(2) + "kWh",
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  Text(
                                    showMonth,
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ]
                              ),
                          ),
                          Card(
                            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            color: Colors.yellow,
                            child: 
                              Column(
                                children: [
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SizedBox(width: 30),
                                      Text(
                                        "Yearly Cost",
                                        style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    year.toStringAsFixed(2) + "kWh",
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  Text(
                                    showYear,
                                    style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.normal
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ]
                              ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 240),
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await DeviceServices.deleteDevice(devices.deviceId).then((value){
                          if(value == true){
                            ActivityServices.showToast("Delete device sucessfull!", Colors.green);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          }else{
                            ActivityServices.showToast("Delete device failed!", Colors.red);
                             setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      },
                      icon: Icon(Icons.delete),
                      label: Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 162, vertical: 7),
                      )
                    ),
                  ],
                ),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}