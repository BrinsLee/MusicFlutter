import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_flutter/common/api/api.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/common/widgets/baseView.dart';
import 'package:music_flutter/view_model/home_view_model.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late BannerViewModel _model;

  @override
  void initState() {
    _model = BannerViewModel(Provider.of<BannerApi>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BannerViewModel>(
      builder: (context, model, child) {
        return _buildContent(context, model);
      },
      model: _model,
      onModelReady: (model) async {
        model.loadBanner(
            context: context,
            request: new BannerRequest('1'),
            refresh: false,
            cacheDisk: true);
      },
    );
  }

  Widget _buildContent(BuildContext context, BannerViewModel model) {
    return model.state == ViewState.dataFetchState
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5),
            height: 130,
            child: Swiper(
              itemCount: model.bannerResult.banners?.length ?? 0,
              itemBuilder: _swiperBuilder,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.black38,
                    activeColor: Colors.white,
                    size: 5.0,
                    activeSize: 5.0),
              ),
              control: null,
              duration: 300,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              loop: true,
              itemWidth: MediaQuery.of(context).size.width - 10,
              // itemHeight: 150,
              // layout: SwiperLayout.TINDER,
              onTap: (index) {},
            ),
          )
        : PKCardPageSkeleton();
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    if (_model.bannerResult.banners == null) {
      return Image.asset(
        "images/base_icon_default_cover.png",
        fit: BoxFit.cover,
      );
    } else {
      return (Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FadeInImage.assetNetwork(
            placeholder: "images/base_icon_default_cover.png",
            image: _model.bannerResult.banners![index]!.picUrl,
            fit: BoxFit.cover,
          ),
        ),
      ));
    }
  }
}
