part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formkey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
      ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(32),
                child: ListView(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 24),
                          Image.asset("assets/images/logo.png", height: 100),
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
                                Icons.person,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return "Please fill the field!";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height:24),
                          TextFormField(
                            controller: ctrlPhone,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Phone",
                              prefixIcon: Icon(
                                Icons.phone,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return "Please fill the field!";
                              }else{
                                if(value.length < 7 || value.length > 14){
                                  return "Phone number isn't valid";
                                }else{
                                  return null;
                                }
                              }
                            },
                          ),
                          SizedBox(height:24),
                          TextFormField(
                            controller: ctrlEmail,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                color: MyTheme.lightTheme().primaryColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.mail_outline_rounded,
                              color: MyTheme.lightTheme().primaryColor,),
                              border: OutlineInputBorder(),
                              labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return "Please fill the field!";
                              }else{
                                if(!EmailValidator.validate(value)){
                                  return "Email is not valid!";
                                }else{
                                  return null;
                                }
                              }
                            },
                          ),
                          SizedBox(height:24),
                          TextFormField(
                            controller: ctrlPassword,
                            style: TextStyle(
                                color: MyTheme.lightTheme().primaryColor,
                            ),
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: MyTheme.lightTheme().primaryColor,
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: new TextStyle(color: MyTheme.lightTheme().primaryColor),
                              suffixIcon: new GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(
                                  isVisible ?
                                  Icons.visibility :
                                  Icons.visibility_off
                                ),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              return value.length < 6 ?
                                "Password must have 6 or more characters":
                                null;
                            },
                          ),
                          SizedBox(height:24),
                          ElevatedButton.icon(
                            onPressed: () async{
                              if(_formkey.currentState.validate()){
                                Users users = new Users("", ctrlName.text, ctrlPhone.text, ctrlEmail.text, ctrlPassword.text, "", 0, 1, "", "");
                                await AuthServices.signUp(users).then((value){
                                  if(value == "success"){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast("Register success", Colors.green);
                                    //menuju ke tahap selanjutnya
                                    Navigator.pushReplacementNamed(context, Login.routeName);
                                    //pushNamed = bisa kembali, ga ditutup
                                  }else{
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(value, Colors.red);
                                  }
                                });
                              }else{
                                //kosongin aja
                                Fluttertoast.showToast(msg: "Please check the fields!", backgroundColor: Colors.red, textColor: Colors.white);
                              }
                            }, 
                            icon: Icon(Icons.save),
                            label: Text("Register"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.lightTheme().primaryColor,
                              elevation: 0,
                            )
                        ),
                        SizedBox(height:24),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, Login.routeName);
                          },
                          child: Text("Alreday registered? Login.",
                            style: TextStyle(
                              color: MyTheme.lightTheme().primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ],
                      )
                    )
                  ],
                ),
              ),
              isLoading == true
                ? ActivityServices.loadings()
                : Container()
            ],
          )
        )
    );
  }
}