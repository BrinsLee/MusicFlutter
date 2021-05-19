import 'package:flutter/material.dart';
import 'package:music_flutter/common/theme/iconfont.dart';
import 'package:music_flutter/common/widgets/customCircularRectAngle.dart';
import 'package:music_flutter/pages/discovery/discoveryPage.dart';
import 'package:music_flutter/pages/home/homePage.dart';
import 'package:music_flutter/pages/me/mePage.dart';
import 'package:music_flutter/pages/video/videoPage.dart';
import 'package:music_flutter/common/theme/config.dart' as config;

class BottomTabNavigation extends StatefulWidget {
  @override
  _BottomTabNavigationState createState() => _BottomTabNavigationState();
}

class _BottomTabNavigationState extends State<BottomTabNavigation>
    with AutomaticKeepAliveClientMixin {
  final _pages = [HomePage(), DiscoveryPage(), VideoPage(), MePage()];
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {},
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  Widget _bottomAppBar() {
    return BottomAppBar(
      elevation: 6,
      notchMargin: 6.0,
      color: Theme.of(context).primaryColor,
      shape: CustomCircularNotchedRectangle(),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _createIconButton(0, icon: Icon(Iconfont.home)),
                _createIconButton(1, icon: Icon(Iconfont.discovery)),
              ],
            ),
          ),
          SizedBox(
            width: 56,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _createIconButton(2, icon: Icon(Iconfont.video)),
                _createIconButton(3, icon: Icon(Iconfont.me)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _createIconButton(int index,
      {Icon icon = const Icon(Iconfont.home), double iconSize = 26}) {
    return IconButton(
      icon: icon,
      onPressed: () {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex,
              duration: Duration(milliseconds: 160), curve: Curves.easeIn);
        });
      },
      color:
          _currentIndex == index ? Theme.of(context).accentColor : Colors.grey,
    );
  }

  Container _floatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).highlightColor,
            Theme.of(context).accentColor
          ],
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      width: 60,
      height: 60,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
