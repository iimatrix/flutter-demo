import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_app/components/animation/container.dart';
import 'package:flutter_demo_app/components/animation/fade.dart';
import 'package:flutter_demo_app/components/animation/physical.dart';
import 'package:flutter_demo_app/components/networking/backend_json.dart';
import 'package:flutter_demo_app/components/networking/delete_app.dart';
import 'file:///E:/resource/mobile/1Flutter/flutter-demo/lib/components/persistence/file_app.dart';
import 'package:flutter_demo_app/components/networking/websocket_app.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  String _title = 'Animation';
  Widget _child = AnimatedContainerApp();
  List<Item> _elItems = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
      ),
      body: _child,
      drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Center(
                child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircleAvatar(
                child: Text('R'),
              ),
            )),
          ),
          ExpansionPanelList(
              expansionCallback: (int panelIndex, bool isExpanded) {
                setState(() {
                  _elItems[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: _elItems.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: item.isExpanded,
                  headerBuilder: (context, bool isExpanded) {
                    return ListTile(
                      leading: item.icon,
                      title: Text('${item.title}'),
                    );
                  },
                  body: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: item.contents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${item.contents[index]}'),
                          onTap: () => {
                            setState(() {
                              _title = item.title;
                              if (item.title == 'Animation') {
                                if (index == 0) {
                                  _child = AnimatedContainerApp();
                                } else if (index == 1) {
                                  _child = FadeApp();
                                } else if (index == 2) {
                                  _child = PhysicsCardDragApp();
                                }
                              } else if (item.title == 'Networking') {
                                if (index == 0) {
                                  _child = DeleteApp();
                                } else if (index == 1) {
                                  _child = WebSocketApp();
                                } else if (index == 2) {
                                  _child = JsonApp();
                                }
                              } else if (item.title == 'Persistence') {
                                if (index == 0) {
                                  _child = FileApp();
                                } else if (index == 1) {
                                  // _child =
                                }
                              } else if (item.title == 'Plugins') {
                                if (index == 0) {
                                  // _child =
                                }
                              }

                              Navigator.pop(context);
                            })
                          },
                        );
                      }),
                );
              }).toList()),
        ],
      ))),
    );
  }
}

class Item {
  bool isExpanded;
  Widget icon;
  String title;
  List<String> contents;

  Item(
      {this.isExpanded = false,
      @required this.title,
      @required this.icon,
      this.contents = const []});
}

List<Item> generateItems() {
  return <Item>[
    Item(title: 'Animation', icon: Icon(Icons.animation), contents: [
      'Container 里的动画渐变效果',
      'Widget 的淡入淡出效果',
      'Widget 的物理模拟动画效果',
      '为页面切换加入动画效果'
    ]),
    Item(title: 'Networking', icon: Icon(Icons.network_cell), contents: [
      '删除网络数据',
      '发起WebSockets请求',
      '在后台处理 JSON 数据解析',
      '获取网络数据'
    ]),
    Item(title: 'Persistence', icon: Icon(Icons.insert_drive_file_outlined), contents: [
      '文件读写',
      '用SQLite 做数据持久化',
    ]),
    Item(title: 'Plugins', icon: Icon(Icons.add), contents: [
      '使用 Camera插件实现拍照功能'
    ]),
  ];
}
