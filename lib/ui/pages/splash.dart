part of 'pages.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splash";
  
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    _loadSplpash();
  }

  _loadSplpash() async{
    var _duration = Duration(seconds: 3);
    return Timer(_duration, checkAuth);
  }

  void checkAuth() async{ 
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser != null){
      Navigator.pushReplacementNamed(context, Home.routeName);
      ActivityServices.showToast("Welcome back "+auth.currentUser.email, Colors.blue);
    }else{
      Navigator.pushReplacementNamed(context, Login.routeName);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("assets/images/logo.png", height: 150),
      ),  
    );
  }
}