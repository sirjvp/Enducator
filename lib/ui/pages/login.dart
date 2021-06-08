part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  bool isVisible = true;
  bool isLoading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login", style: TextStyle(color: Colors.white)),
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
                ListView(
                  padding: EdgeInsets.all(32),
                  children: [
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            Image.asset("assets/images/logo.png", height: 100),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: ctrlEmail,
                              keyboardType: TextInputType.emailAddress,
                              // focusNode: myFocusNode,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus ? Colors.black : Colors.black
                                ),
                                prefixIcon: Icon(
                                  Icons.mail_outline_rounded,
                                  color: myFocusNode.hasFocus ? Colors.grey: Colors.grey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                email = value;
                                if (value.isEmpty) {
                                  return "Please fill the field!";
                                } else {
                                  if (!EmailValidator.validate(value)) {
                                    return "Email is not valid!";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: ctrlPassword,
                              obscureText: isVisible,
                              // focusNode: myFocusNode,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus ? Colors.black : Colors.black
                                ),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: myFocusNode.hasFocus ? Colors.grey: Colors.grey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: new GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: Icon(isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                      color: myFocusNode.hasFocus ? Colors.grey: Colors.grey),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                password = value;
                                return value.length < 6
                                    ? "Password must have 6 or more characters"
                                    : null;
                              },
                            ),
                            SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await AuthServices.signIn(
                                          ctrlEmail.text, ctrlPassword.text)
                                      .then((value) {
                                    if (value == "success") {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ActivityServices.showToast(
                                          "Login success", Colors.green);
                                      //menuju ke tahap selanjutnya
                                      Navigator.pushReplacementNamed(
                                          context, Home.routeName);
                                      //pushNamed = bisa kembali, ga ditutup
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ActivityServices.showToast(
                                          value, Colors.red);
                                    }
                                  });
                                } else {
                                  //kosongin aja
                                  Fluttertoast.showToast(
                                      msg: "Please check the fields!",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white);
                                }
                              },
                              icon: Icon(Icons.login_rounded),
                              label: Text("Login"),
                              style: ElevatedButton.styleFrom(
                                primary: MyTheme.lightTheme().accentColor,
                                elevation: 0,
                              ),
                            ),
                            SizedBox(height: 24),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Register.routeName);
                              },
                              child: Text(
                                "Not registerd yet? Join Now.",
                                style: TextStyle(
                                  color: MyTheme.lightTheme().primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                isLoading == true ? ActivityServices.loadings() : Container()
              ],
            )));
  }
}
