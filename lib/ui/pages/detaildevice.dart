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
  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();

  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Devices devices = ModalRoute.of(context).settings.arguments;
    ctrlName.text = devices.deviceName;
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
                          // ElevatedButton.icon(
                          //   onPressed: () async {
                          //     if(_formkey.currentState.validate()){
                          //       setState(() {
                          //         isLoading = true;
                          //       });
                          //       String name = ctrlName.text;
                          //       await AuthServices.updateSetting(ctrlName.text).then((value){
                          //         if(value == "success"){
                          //           ActivityServices.showToast("Edit setting sucessfull!", Colors.green);
                          //           setState(() {
                          //             isLoading = false;
                          //           });
                          //           Navigator.pop(context);
                          //         }else{
                          //           ActivityServices.showToast("Save setting failed!", Colors.red);
                          //           setState(() {
                          //             isLoading = false;
                          //           });
                          //         }
                          //       });
                          //     }else{
                          //       ActivityServices.showToast("Please check form fields!", Colors.red);
                          //     }
                          //   },
                          //   icon: Icon(Icons.save),
                          //   label: Text("Save"),
                          //   style: ElevatedButton.styleFrom(
                          //     primary: MyTheme.lightTheme().primaryColor,
                          //     elevation: 0,
                          //     padding: EdgeInsets.symmetric(horizontal: 135, vertical: 7),
                          //   )
                          // ),
                        ],
                      )),
                ]),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}