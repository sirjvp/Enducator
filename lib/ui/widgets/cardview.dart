part of 'widgets.dart';

class CardView extends StatefulWidget {
  final Devices devices;
  CardView({this.devices});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    Devices device = widget.devices;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          children: [
            ListTile(
              leading: 
              Image.asset("assets/images/tv.png", height: 100),
              // CircleAvatar(
              //   radius: 24.0,
                // backgroundImage: NetworkImage(device.deviceImage),
              // ),
              
              title: Text(
                device.deviceName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 1,
                softWrap: true,
              ),
              subtitle: Text(
                device.deviceWatt.toString(),
                // ActivityServices.toIDR(device.devicePrice),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(
                  //   icon: Icon(CupertinoIcons.trash_circle_fill),
                  //   color: Colors.red,
                  //   onPressed: (){

                  //   },
                  // ),
                  IconButton(
                    icon: Icon(CupertinoIcons.ellipses_bubble_fill),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pushNamed(context, DetailDevice.routeName, arguments: device);
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext ctx) {
                      //     return Container(
                      //       width: double.infinity,
                      //       height: double.infinity,
                      //       padding: EdgeInsets.all(32),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           ElevatedButton.icon(
                      //             icon: Icon(CupertinoIcons.eye_fill),
                      //             label: Text("Show Data"),
                      //             onPressed: () {},
                      //             style: ElevatedButton.styleFrom(
                      //                 primary: Colors.blueGrey),
                      //           ),
                      //           ElevatedButton.icon(
                      //             icon: Icon(CupertinoIcons.pencil),
                      //             label: Text("Edit Data"),
                      //             onPressed: () {},
                      //           ),
                      //           ElevatedButton.icon(
                      //             icon: Icon(CupertinoIcons.trash_fill),
                      //             label: Text("Delete Data"),
                      //             onPressed: () async {
                      //               bool result = await DeviceServices.deleteDevice(device.deviceId);
                      //               if(result){
                      //                 ActivityServices.showToast("Delete data success.", Colors.green);
                      //               }else{
                      //                 ActivityServices.showToast("Delete data failed.", Colors.red);
                      //               }
                      //             },
                      //             style: ElevatedButton.styleFrom(
                      //                 primary: Colors.red[600]),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}