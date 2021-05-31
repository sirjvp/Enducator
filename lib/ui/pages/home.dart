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
    AddDevice(),
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/report.png", height: 20),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Devices',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/me.png", height: 20),
            label: 'My Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
      ),


      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // bottomNavigationBar: BubbleBottomBar(
      //   opacity: .2,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      //   elevation: 8,
      //   fabLocation: BubbleBottomBarFabLocation.end, //new
      //   hasNotch: true, //new
      //   hasInk: true, //new, gives a cute ink effect
      //   inkColor: Colors.black12, //optional, uses theme color if not specified
      //   items: <BubbleBottomBarItem>[
      //       BubbleBottomBarItem(
      //         backgroundColor: Colors.indigo,
      //         icon: Image.asset("assets/images/report.png", height: 20),
      //         activeIcon: Image.asset("assets/images/report.png", height: 20), title: Text("Report")
      //       ),
      //       BubbleBottomBarItem(
      //         backgroundColor: Colors.indigo,
      //         icon: Image.asset("assets/images/me.png", height: 20),
      //         activeIcon: Image.asset("assets/images/me.png", height: 20), title: Text("My Account")
      //       ),
      //       BubbleBottomBarItem(backgroundColor: Colors.indigo, icon: Icon(Icons.folder_open, color: Colors.black,), activeIcon: Icon(Icons.folder_open, color: Colors.indigo,), title: Text("Folders")),
      //       BubbleBottomBarItem(backgroundColor: Colors.green, icon: Icon(Icons.menu, color: Colors.black,), activeIcon: Icon(Icons.menu, color: Colors.green,), title: Text("Menu"))
      //   ],
      // ),
    );
  }
}