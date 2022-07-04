import 'package:f_suv_web_b/content_view.dart';
import 'package:f_suv_web_b/custom_tab.dart';
import 'package:f_suv_web_b/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  var scaffoldkey = GlobalKey<ScaffoldState>();

  double? screenWidth;
  double? screenHeight;
  double? topPadding;
  double? bottomPadding;

  List<ContentView> contentViews = [
    ContentView(
      tab: CustomTab(title: 'Home',),
      content: Center(
        child: Container(color: Colors.green, width: 100, height: 100,),
      ),
    ),
    ContentView(
      tab: CustomTab(title: 'About',),
      content: Center(
        child: Container(color: Colors.blue,width: 100,height: 100,),
      ),
    ),
    ContentView(
      tab: CustomTab(title: 'Projects',),
      content: Center(
        child: Container(color: Colors.red,width: 100,height: 100,),
      )
    )
  ];

  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight! * 0.05;
    bottomPadding = screenHeight! * 0.01;

    return Scaffold(
      backgroundColor: Color(0xff1e1e24),
      endDrawer: drawer(),
      key: scaffoldkey,
      body: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding!,top:  topPadding!),
        child: LayoutBuilder(
          builder: (context,constraints){
            if(constraints.maxWidth > 715){
              return deskTopView();
            }else{
              return mobileView();
            }
          },
        ),
      ),
    );
  }

  Widget deskTopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
          controller: TabController(length: contentViews.length, vsync: this),
          tabs: contentViews.map((e) => e.tab).toList(),
        ),
        Container(
          height: screenHeight! * 0.85,
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.tab).toList(),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth! * 0.05,right: screenWidth! * 0.05),
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              iconSize: screenWidth! * 0.08,
              onPressed: () => scaffoldkey.currentState!.openEndDrawer(),
              icon: Icon(Icons.menu_rounded),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer(){
    return Drawer(
      child: ListView(
        children: [Container(height: screenHeight! * 0.1,)]+contentViews.map((e) =>
          Container(
            child: ListTile(
              title: Text(e.tab.title.toString()),
              onTap: (){

              },
            ),
          )
        ).toList(),
      ),
    );
  }

}
