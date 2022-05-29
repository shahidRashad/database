import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/screens/DataCard.dart';
import 'package:login/model/ModelClass.dart';
import 'package:login/screens/editingPage.dart';

import '../helper/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State {
  late DatabaseHelper db;
  List<ModelClass> datas = [];
  bool fetch = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
    getDatas();
  }

  void getDatas() async {
    datas = await db.getData();

    setState(() {
      fetch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: fetch
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemBuilder: (context, index) => DataCard(
                    data: datas[index],
                    index: index,
                    delete: delete,
                  ),
                  itemCount: datas.length,
                ),
              ));
  }

  void delete(int index) {
    db.delete(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }
}
