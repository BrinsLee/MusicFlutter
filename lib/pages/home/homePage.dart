import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/widgets/bannerWidget.dart';
import 'package:music_flutter/common/widgets/baseView.dart';
import 'package:music_flutter/common/widgets/daily_recommend_widget.dart';
import 'package:music_flutter/common/widgets/newAlbumWidget.dart';
import 'package:music_flutter/common/widgets/personalized_musiclist_widget.dart';
import 'package:music_flutter/common/widgets/personalized_new_music_widget.dart';
import 'package:music_flutter/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:music_flutter/common/widgets/customTabs.dart' as CustomTabBar;
import 'package:music_flutter/common/widgets/customIndicator.dart'
    as CustomIndicator;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EasyRefreshController _controller; // EasyRefresh控制器
  bool _refresh = false;
  BannerViewModel _bannerViewModel;
  PersonalizedMusicViewModel _musicViewModel;
  NewestAlbumViewModel _albumViewModel;
  List<Tab> _tabs = [
    Tab(text: "新专辑"),
    Tab(
      text: "新歌",
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    _bannerViewModel = BannerViewModel(Provider.of<BannerApi>(context));
    _musicViewModel =
        PersonalizedMusicViewModel(Provider.of<PersonalizedApi>(context));
    _albumViewModel = NewestAlbumViewModel(Provider.of<NewestApi>(context));
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
                "assets/images/base_icon_search_black.png",
                width: 30,
                height: 30,
              ),
              onPressed: null)
        ],
      ),
      body: EasyRefresh(
          enableControlFinishRefresh: true,
          controller: _controller,
          header: ClassicalHeader(),
          onRefresh: () {
            setState(() async {
              _bannerViewModel.loadBanner(
                  context: context,
                  request: new BannerRequest('1'),
                  refresh: true,
                  cacheDisk: true);
            });
            return;
          },
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
        _buildBannerWidget(),
        Container(
          margin: EdgeInsets.all(10),
          child: DailyRecommend(),
        ),
        _buildMusicListTitle(),
        _buildPersonalizedMusicListWidget(),
        _buildNewMusicTitle(),
        _buildNewMusicWidget(),
        _buildTab(),
      ],
    );
  }

  Widget _buildBannerWidget() {
    return BaseView<BannerViewModel>(
      builder: (context, model, child) {
        return BannerWidget(_bannerViewModel);
      },
      model: _bannerViewModel,
      onModelReady: (model) async {
        model.loadBanner(
            context: context,
            request: new BannerRequest('1'),
            refresh: _refresh,
            cacheDisk: true);
      },
    );
  }

  Widget _buildPersonalizedMusicListWidget() {
    return BaseView<PersonalizedMusicViewModel>(
      builder: (context, model, child) {
        return PersonalizedMusicListWidget(_musicViewModel);
      },
      model: _musicViewModel,
      onModelReady: (model) async {
        model.loadPersonalizedMusicList(
            context: context, refresh: _refresh, cacheDisk: true);
      },
    );
  }

  Widget _buildNewMusicWidget() {
    return BaseView<PersonalizedMusicViewModel>(
      builder: (context, model, child) {
        return PersonalizedNewMusicWidget(_musicViewModel);
      },
      model: _musicViewModel,
      onModelReady: (model) async {
        model.loadPersonalizedNewMusic(
            context: context, refresh: false, cacheDisk: true);
      },
    );
  }

  Widget _buildNewMusicTitle() {
    return Container(
        margin: EdgeInsets.only(left: 15, bottom: 10, right: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              "晚霞灿烂，音乐惬意",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                  overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(100, 191, 191, 191)),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.grey, width: 1)),
                  shape: MaterialStateProperty.all(
                    StadiumBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.only(
                      left: 8.0, top: 4.0, right: 8.0, bottom: 5.0))),
              child: Text(
                '查看更多',
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ));
  }

  Widget _buildMusicListTitle() {
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        "根据你喜欢歌曲推荐",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTab() {
    return DefaultTabController(
      length: _tabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });
          return Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.fromLTRB(4, 10, 4, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        // bottomRight: Radius.circular(28),
                        // bottomLeft: Radius.circular(28),
                        ),
                  ),
                  child: _buildTabBar(),
                ),
                Container(
                  height: 340,
                  child: CustomTabBar.TabBarView(
                    children: [
                      _buildTabView("新专辑"),
                      _buildTabView("新歌"),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return CustomTabBar.TabBar(
      onTap: (index) {},
      labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      labelStyle: TextStyle(
        color: Colors.black54.withOpacity(0.6),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Proxima Nova',
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey.shade400,
      unselectedLabelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Proxima Nova',
      ),
      indicatorSize: CustomTabBar.TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
      indicatorWeight: 2.2,
      indicator: CustomIndicator.UnderlineTabIndicator(
        hPadding: 15,
        borderSide: BorderSide(width: 3, color: Theme.of(context).accentColor),
        insets: EdgeInsets.zero,
      ),
      isScrollable: true,
      tabs: _tabs,
    );
  }

  Widget _buildTabView(String tabName) {
    switch (tabName) {
      case "新专辑":
        {
          return BaseView<NewestAlbumViewModel>(
            builder: (context, model, child) {
              return NewAlbumWidget(_albumViewModel);
            },
            model: _albumViewModel,
            onModelReady: (model) async {
              model.loadNewestAlbum(
                  context: context, refresh: _refresh, cacheDisk: true);
            },
          );
          break;
        }
      case "新歌":
        {
          return Container();
          break;
        }
      default:
        {
          return Container();
        }
    }
  }
}
