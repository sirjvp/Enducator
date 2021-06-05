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
  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlWatt = TextEditingController();
  final ctrlQuantity = TextEditingController();
  final ctrlDay = TextEditingController();
  final ctrlTime = TextEditingController();
  int ctrlImage = 1;
  String deviceId = "";

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
                ListView(padding: EdgeInsets.all(16), children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          DropdownButton(
                              value: ctrlImage,
                              style: TextStyle(
                                color: MyTheme.lightTheme().primaryColor,
                                fontSize: 16,
                              ),
                              underline: Container(
                                height: 2,
                                color: Colors.black26,
                              ),
                              dropdownColor: MyTheme.lightTheme().scaffoldBackgroundColor,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Custom"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Light Bulb"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("TV"),
                                  value: 3
                                ),
                                DropdownMenuItem(
                                  child: Text("Air Conditioner"),
                                  value: 4
                                ),
                                DropdownMenuItem(
                                  child: Text("Charger"),
                                  value: 5
                                ),
                                DropdownMenuItem(
                                  child: Text("Speaker"),
                                  value: 6
                                ),
                                DropdownMenuItem(
                                  child: Text("Water"),
                                  value: 7
                                ),
                                DropdownMenuItem(
                                  child: Text("Refrigerator"),
                                  value: 8
                                ),
                                DropdownMenuItem(
                                  child: Text("Microwave"),
                                  value: 9
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  ctrlImage = value;
                                  isClicked = true;
                                });
                              }
                            ),
                          // ),
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Watt",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlWatt,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlQuantity,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Day Usage",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlDay,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Time Usage",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: ctrlTime,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.money,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              // border: OutlineInputBorder(),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: MyTheme.lightTheme().primaryColor,
                                    width: 2),
                              ),
                              labelStyle: new TextStyle(
                                  color: MyTheme.lightTheme().primaryColor),
                            ),
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
                          ElevatedButton.icon(
                            onPressed: () async {
                              if(_formkey.currentState.validate()){
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
                              }else{
                                ActivityServices.showToast("Please check form fields!", Colors.red);
                              }
                            },
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                            )
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                                
                                Devices devices = Devices(deviceId, ctrlName.text, int.parse(ctrlWatt.text), int.parse(ctrlQuantity.text), int.parse(ctrlDay.text), int.parse(ctrlTime.text), ctrlImage.toString(), FirebaseAuth.instance.currentUser.uid, "", "");
                                await DeviceServices.updateDevice(devices).then((value){
                                  if(value == "success"){
                                    ActivityServices.showToast("Save device sucessfull!", Colors.green);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  }else{
                                    ActivityServices.showToast("Save device failed!", Colors.red);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
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
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}