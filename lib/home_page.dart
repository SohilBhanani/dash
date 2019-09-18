import 'package:flutter/material.dart';
import 'package:dash/util/fashion.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool favourite;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  void favPress() {
    setState(() {
      favourite ? favourite = false : favourite = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        title: Center(
          child: Text(
            "Dash-Wall",
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "|",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DefaultTabController(
                length: 2,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.black.withOpacity(0.4),
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.transparent),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Popular",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 128,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: fashion.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (BuildContext context, int index){
                          Map fas = fashion[index];
                          return CircularItem(fas["img"]);
                        }
                        )
//                  GridView.count(
//                    crossAxisCount: 2,
//                    crossAxisSpacing: 5.0,
//                    mainAxisSpacing: 5.0,
//                    children: <Widget>[
//                      CircularItem("assets/fashion/f1.jpg"),
//                      Container(
//                        color: Colors.green,
//                      ),
//                      Container(
//                        color: Colors.red,
//                      ),
//                      Container(
//                        color: Colors.blue,
//                      ),
//                      Container(
//                        color: Colors.green,
//                      ),
//                      Container(
//                        color: Colors.red,
//                      ),
//                      Container(
//                        color: Colors.blue,
//                      ),
//                      Container(
//                        color: Colors.green,
//                      ),
//                      Container(
//                        color: Colors.red,
//                      ),
//                    ],
//                  ),
                    ),
                Container(
                  height: 150.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),

      //Tabbar ends here
    );
  }

  Widget CircularItem(String imagePath) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image:
              DecorationImage(fit: BoxFit.cover, image: AssetImage(imagePath)),
        )),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 40.0,
            width: 40.0,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 25.0,
                color: favourite == true ? Colors.red : Colors.white,
              ),
              onPressed: () => favPress(),
            ),
          ),
        ),
      ],
    );
  }
}
