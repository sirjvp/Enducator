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
    String pickedImage = "assets/icons/flash.png";
    if(device.deviceImage == "2"){
      pickedImage = "assets/icons/bulb.png";
    }else if(device.deviceImage == "3"){
      pickedImage = "assets/icons/tv.png";
    }else if(device.deviceImage == "4"){
      pickedImage = "assets/icons/air-conditioner.png";
    }else if(device.deviceImage == "5"){
      pickedImage = "assets/icons/plug.png";
    }else if(device.deviceImage == "6"){
      pickedImage = "assets/icons/speaker.png";
    }else if(device.deviceImage == "7"){
      pickedImage = "assets/icons/bathing.png";
    }else if(device.deviceImage == "8"){
      pickedImage = "assets/icons/fridge.png";
    }else if(device.deviceImage == "9"){
      pickedImage = "assets/icons/microwave.png";
    }else if(device.deviceImage == "10"){
      pickedImage = "assets/icons/washing-machine.png";
    }else{
      pickedImage = "assets/icons/flash.png";
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailDevice.routeName, arguments: device);
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Column(
            children: [
              ListTile(
                leading: 
                  Image.asset(pickedImage, height: 100),
                title: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 50,
                      child: Text(
                        "Days",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        "Hours",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        "Watts",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                  ]
                ),
                subtitle: Row(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        device.deviceName,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 50,
                      child: Text(
                        device.deviceDay.toString(),
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        device.deviceTime.toString(),
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        device.deviceWatt.toString(),
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}