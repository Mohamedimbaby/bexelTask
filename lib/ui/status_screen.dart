import 'package:bexel_task/data/statistics.dart';
import 'package:bexel_task/utils/colors.dart';
import 'package:bexel_task/utils/dimensions.dart';
import 'package:bexel_task/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:stacked_listview/stacked_listview.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> with SingleTickerProviderStateMixin{
  double itemHeight = Dimensions.height * .3 ;
  double itemWidth = Dimensions.height * .5 ;
  List<Statistics> data = [
    Statistics("Expiry date closest" , "P1", secondColor),
    Statistics("Active Products Percent" , "30 %", mainColor),
    Statistics("Most City Availability" , "Cairo 30%", thirdColor),


  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeaderSection(context, "Home"),
        Container(
          margin: const EdgeInsets.only(bottom: 20, right: 20),
          height: Dimensions.height *.62,
          child: StackedListView(
            animateDuration: const Duration(seconds: 1),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50,bottom: 20),
            itemCount: data.length,
            itemExtent: itemHeight,
            heightFactor: 0.8,
            fadeOutFrom: 0.7,
              builder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: data[index].color,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data[index].info,
                          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
              );
            },
          ),
        ),
      ],
    );
  }
}
