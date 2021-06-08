part of 'widgets.dart';

class ReportCard extends StatefulWidget {
    final Calculate calculate;
    ReportCard({this.calculate});

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isLoading = false;
  String showTotal = "";

  void dialogBox(BuildContext ctx, String rid){
    showDialog(
      context: ctx,
      builder: (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete?"),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async{
                  Navigator.pop(context);
                  await CalculateServices.deleteReport(rid).then((value){
                    if(value == true){
                      ActivityServices.showToast("Delete report sucessful!", Colors.green);
                      
                    }else{
                      ActivityServices.showToast("Delete report failed!", Colors.red);
                    }
                  });
                },
                child: Text(
                        "Yes",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text(
                        "No",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Calculate calculate = widget.calculate;
    if(calculate.createdAt == '2'){
      showTotal = ActivityServices.toUS(calculate.price.toString());
    }else{
      showTotal = ActivityServices.toIDR(calculate.price.toString());
    }
    return GestureDetector(
      onTap: () async{
        String rid = calculate.reportId;
        dialogBox(context, rid);
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Date",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 80,
                      child: Text(
                        "Total Kwh",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 60,
                      child: Text(
                        "Devices",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        "Price",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black38),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                  ]
                ),
                subtitle: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        calculate.time,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 80,
                      child: Text(
                        calculate.totalWatt.toString(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 60,
                      child: Text(
                        calculate.totalDevice.toString(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                        softWrap: true,
                      )
                    ),
                    Container(
                      width: 110,
                      child: Text(
                        showTotal,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
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
    );
  }
}