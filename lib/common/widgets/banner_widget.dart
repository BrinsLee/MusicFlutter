import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/view_model/home_view_model.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class BannerWidget extends StatefulWidget {
  final BannerViewModel _model;

  BannerWidget(this._model);

  @override
  _BannerWidgetState createState() => _BannerWidgetState(_model);
}

class _BannerWidgetState extends State<BannerWidget> {
  BannerViewModel _model;

  _BannerWidgetState(this._model);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BannerWidget oldWidget) {
    print("bannerWidget: didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("bannerWidget: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("bannerWidget: dispose");
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return _model.state == ViewState.dataFetchState
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(5),
            height: 130,
            child: Swiper(
              itemCount: _model.bannerResult.banners?.length ?? 0,
              itemBuilder: _swiperBuilder,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.black38,
                    activeColor: Colors.white,
                    size: 5.0,
                    activeSize: 5.0),
              ),
              control: null,
              duration: 800,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              loop: true,
              itemWidth: MediaQuery.of(context).size.width - 10,
              // itemHeight: 150,
              // layout: SwiperLayout.TINDER,
              onTap: (index) {},
            ),
          )
        : PKCardPageSkeleton(
            totalLines: 1,
          );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    if (_model.bannerResult == null || _model.bannerResult.banners == null) {
      return Image.asset(
        "assets/images/base_icon_default_cover.png",
        fit: BoxFit.cover,
      );
    } else {
      return (Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/base_icon_default_cover.png",
            image: _model.bannerResult.banners[index].picUrl,
            fit: BoxFit.cover,
          ),
        ),
      ));
    }
  }
}
