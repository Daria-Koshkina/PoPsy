import "package:flutter/material.dart";
import 'package:po_psy/assets/my_icons_icons.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/pages/homeScreen/diary/diary.dart';
import 'package:po_psy/pages/homeScreen/recommendations/recommendationsPage.dart';
import 'package:po_psy/pages/homeScreen/tests/tests.dart';

import 'account/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  final List<MyTab> _tabs = [
    new MyTab(title: "News", icon: Icon(MyIcons.video)),
    new MyTab(title: "Tests", icon: Icon(MyIcons.list_alt)),
    new MyTab(title: "Diary", icon: Icon(MyIcons.edit)),
    new MyTab(title: "Account", icon: Icon(MyIcons.account_circle))
  ];

  MyTab _myHandler ;
  TabController _controller ;
  void initState() {
    super.initState();
    _controller = new TabController(length: _tabs.length, vsync: this);
    _myHandler = _tabs[0];
    _controller.addListener(_handleSelected);
  }
  
  void _handleSelected() {
    setState(() {
      _myHandler = _tabs[_controller.index];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_myHandler.title, style: TextStyles.topBarTextStyle,),
        backgroundColor: ColorPallet.backgroundColor,
        bottom: new TabBar(
          labelColor: ColorPallet.mainColor,
          unselectedLabelColor: ColorPallet.placeholderColor,
          controller: _controller,
          tabs: <Tab>[
            new Tab(icon: _tabs[0].icon),
            new Tab(icon: _tabs[1].icon),
            new Tab(icon: _tabs[2].icon),
            new Tab(icon: _tabs[3].icon)
          ],
        ),),
      body: TabBarView(
        controller: _controller,
        children: _tabs.map((MyTab tab) {
          return SelectedPage(page: tab.title);
        }).toList(),
      ),
    );
  }
}

class SelectedPage extends StatelessWidget {
  SelectedPage({this.page});
  final String page;

  @override
  Widget build(BuildContext context) {
    if (page == 'News') {
      return RecommendationsPage();
    }
    else if (page == 'Tests') {
      return TestsPage();
    }
    else if (page == 'Diary') {
      return DiaryPage();
    }
    else {
      return AccountPage();
    }
  }
}

class MyTab {
  final String title;
  final Icon icon;
  MyTab({this.title,this.icon});
}
