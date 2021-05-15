import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/widgets/bannerWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EasyRefreshController _controller; // EasyRefresh控制器

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'LightMusic',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: Image.asset(
                "images/base_icon_search_black.png",
                width: 50,
                height: 50,
              ),
              onPressed: null)
        ],
      ),
      body: EasyRefresh(
          enableControlFinishRefresh: true,
          controller: _controller,
          header: ClassicalHeader(),
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: _buildDataView(),
          )),
    );
  }

  void _loadAllData() {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDataView() {
    return Column(
      children: [
        BannerWidget()
      ],
    );
  }
}
