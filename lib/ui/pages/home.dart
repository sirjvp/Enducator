part of 'pages.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptios = <Widget>[
    Report(),
    MyAccount(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptios.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddDevice.routeName);
        },
        child: Icon(Icons.add, color: Colors.black87),
        backgroundColor: MyTheme.lightTheme().primaryColor,
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Image.asset("assets/images/report.png", height: 20),
      //       label: 'Report',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: 'Add Devices',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("assets/images/me.png", height: 20),
      //       label: 'My Account',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   elevation: 8,
      // ),

      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: MyTheme.lightTheme().accentColor,
        opacity: .2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Image.asset("assets/images/report.png", height: 20),
              activeIcon: Image.asset("assets/images/report.png", height: 20), title: Text("Report", style: TextStyle(color: Colors.white),)
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Image.asset("assets/images/me.png", height: 20),
              activeIcon: Image.asset("assets/images/me.png", height: 20), title: Text("My Account", style: TextStyle(color: Colors.white),)
            ),
            
        ],
      ),
    );

  }
}