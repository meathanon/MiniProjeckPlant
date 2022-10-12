// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:myfirstapp/until/colors.dart';
import 'package:myfirstapp/widgets/big_text.dart';
import 'package:myfirstapp/widgets/small_text.dart';
import 'package:unicons/unicons.dart';

import 'plant_page_body.dart';

import '../../model/login_model.dart';

class MainPlantPage extends StatefulWidget {
  static const routeName = '/';
  final String id;

  MainPlantPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MainPlantPage> createState() => _MainPlantPageState();
}

class _MainPlantPageState extends State<MainPlantPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmember();

    print('Test : ${widget.id}');
  }

  List<ModelUserMember> memberlist = [];
  Future getmember() async {
    var url = Uri.parse('http://10.0.2.2/connectPHP/select.php');
    var response1 = await http.post(url, body: {
      'user_id': widget.id,
    });
    var data = jsonDecode(response1.body);
    print(data);
    for (var i = 0; i < data.length; i++) {
      ModelUserMember user = ModelUserMember(
        username: data[i]['username'],
      );
      this.memberlist.add(user);
    }
    print('ttttttt: $memberlist');
    return memberlist;
  }

  @override
  Widget build(BuildContext context) {
    // print('screen = ' + MediaQuery.of(context).size.height.toString());
    return Scaffold(
        body: Column(
      children: [
        //header
        Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(top: 70, bottom: 15),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Plantyshop',
                      color: AppColors.maincolor,
                    ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       height: 100,
                    //       // width: 100,
                    //       child: ListView.builder(
                    //         scrollDirection: Axis.horizontal,
                    //         shrinkWrap: true,
                    //         // itemExtent: 95.0,
                    //         itemCount: memberlist.length,
                    //         itemBuilder: (context, index) {
                    //           return ListTile(title: SmallText(text: 'test',color: Colors.amber,),);
                    //         },
                    //       ),
                    //     ),
                    //     // Icon(Icons.arrow_drop_down_rounded)
                    //   ],
                    // )
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(
                      UniconsLine.search,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.maincolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //body slide
        Expanded(
            child: SingleChildScrollView(
          child: PlantPageBody(),
        ))
      ],
    ));
  }
}