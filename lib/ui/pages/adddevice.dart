part of 'pages.dart';

class AddDevice extends StatefulWidget {
  static const String routeName = "/adddevice";

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlWatt = TextEditingController();
  final ctrlQuantity = TextEditingController();
  final ctrlDay = TextEditingController();
  final ctrlTime = TextEditingController();
  int ctrlImage = 1;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlWatt.dispose();
    ctrlQuantity.dispose();
    ctrlDay.dispose();
    ctrlTime.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlWatt.clear();
    ctrlQuantity.clear();
    ctrlDay.clear();
    ctrlTime.clear();
  }

  @override
  Widget build(BuildContext context) {
    if(ctrlImage == 2){
      ctrlName.text = "Light Bulb";
      ctrlWatt.text = "10";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "9";
    }else if(ctrlImage == 3){
      ctrlName.text = "LED TV";
      ctrlWatt.text = "70";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "3";
    }else if(ctrlImage == 4){
      ctrlName.text = "AC Stardard 1/2 PK";
      ctrlWatt.text = "400";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "9";
    }else if(ctrlImage == 5){
      ctrlName.text = "Charger";
      ctrlWatt.text = "6";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "1";
    }else if(ctrlImage == 6){
      ctrlName.text = "Speaker";
      ctrlWatt.text = "150";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "2";
    }else if(ctrlImage == 7){
      ctrlName.text = "Water";
      ctrlWatt.text = "500";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "2";
    }else if(ctrlImage == 8){
      ctrlName.text = "Refrigerator (Large)";
      ctrlWatt.text = "780";
      ctrlQuantity.text = "1";
      ctrlDay.text = "24";
      ctrlTime.text = "30";
    }else if(ctrlImage == 9){
      ctrlName.text = "Microwave";
      ctrlWatt.text = "1000";
      ctrlQuantity.text = "1";
      ctrlDay.text = "1";
      ctrlTime.text = "0.25";
    }else if(ctrlImage == 10){
      ctrlName.text = "Washing Machine";
      ctrlWatt.text = "500";
      ctrlQuantity.text = "1";
      ctrlDay.text = "30";
      ctrlTime.text = "0.25";
    }else{
      ctrlName.text = "";
      ctrlWatt.text = "";
      ctrlQuantity.text = "";
      ctrlDay.text = "";
      ctrlTime.text = "";
    }
    
    return Scaffold(
        appBar: AppBar(
          title: Text("ADD DEVICE", style: TextStyle(color: Colors.white)),
          backgroundColor: MyTheme.lightTheme().accentColor,
          brightness: Brightness.dark,
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
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     color: Colors.cyan,
                          //     border: Border.all()),
                          //   child:
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
                                DropdownMenuItem(
                                  child: Text("Washing Machine"),
                                  value: 10
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  ctrlImage = value;
                                });
                              }
                            ),
                          // ),
                          SizedBox(height: 24),
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: Icon(
                                Icons.label,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
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
                          TextFormField(
                            controller: ctrlWatt,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            // maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Watt",
                              prefixIcon: Icon(
                                Icons.power,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
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
                          TextFormField(
                            controller: ctrlQuantity,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              prefixIcon: Icon(
                                Icons.confirmation_number,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
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
                          TextFormField(
                            controller: ctrlDay,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Day Usage (Days)",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
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
                          TextFormField(
                            controller: ctrlTime,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Time Usage (Hours)",
                              prefixIcon: Icon(
                                Icons.lock_clock,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
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
                          ElevatedButton.icon(
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Devices devices = Devices(
                                      "",
                                      ctrlName.text,
                                      int.parse(ctrlWatt.text),
                                      int.parse(ctrlQuantity.text),
                                      int.parse(ctrlDay.text),
                                      int.parse(ctrlTime.text),
                                      ctrlImage.toString(),
                                      FirebaseAuth.instance.currentUser.uid,
                                      "",
                                      "");
                                  await DeviceServices.addDevice(devices).then((value) {
                                    if (value == true) {
                                      ActivityServices.showToast("Add device sucessfull!",Colors.green);
                                      // clearForm();
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context, Home.routeName);
                                    } else {
                                      ActivityServices.showToast("Add device failed!", Colors.red);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                } else {
                                  ActivityServices.showToast(
                                      "Please check form fields!", Colors.red);
                                }
                              },
                              icon: Icon(Icons.save),
                              label: Text("Save Device"),
                              style: ElevatedButton.styleFrom(
                                primary: MyTheme.lightTheme().primaryColor,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 135, vertical: 7),
                              )),
                        ],
                      )),
                ]),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}
