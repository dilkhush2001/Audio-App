import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Message.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.deepOrange,
        leading: IconButton(onPressed: (){},icon: Icon(Icons.menu),),
        title: Text('Chats'),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepOrange,
            child: TabBar(
              controller: _tabController,
              splashBorderRadius: BorderRadius.circular(12),
              labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Message',),
                Tab(text: 'Online'),
                Tab(text: 'Group'),
                Tab(text: 'Request'),
              ],
              indicator: BoxDecoration(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Message(),
                Center(child: Text('Tab 2 content')),
                Center(child: Text('Tab 3 content')),
                Center(child: Text('Tab 4 content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}