import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';

class NewAlbumItemWidget extends StatelessWidget {
  List<NewestAlbum> _list;
  int _start;
  int _end;

  NewAlbumItemWidget(this._list, {int start = 0, int end = 0}) {
    this._start = start;
    this._end = end;
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null || _start < 0 || _end > _list.length) {
      return Container();
    } else {
      return _buildAlbum();
    }
  }

  Widget _buildAlbum() {
    List<Widget> widgets = [];
    for (int i = _start; i < _end && i < _list.length; i++) {
      widgets.add(_buildListItem(_list[i]));
    }
    return Container(
      width: ScreenUtil().screenWidth - 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: widgets,
      ),
    );
  }

  Widget _buildListItem(NewestAlbum album) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: ScreenUtil().screenWidth - 80,
        height: 95,
        child: Stack(
          children: [
            Positioned(
              top: 15.0,
              left: 10.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(217, 217, 217, 0.8),
                        offset: Offset(6.0, 3.0),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]),
                width: ScreenUtil().screenWidth - 100,
                height: 80,
                padding: EdgeInsets.fromLTRB(100, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${album.name}",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "${album.artist.name}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              child: Image.asset(
                "assets/images/home_ic_vinyl_record.png",
                width: 80,
                height: 80,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/base_icon_default_cover.png",
                image: album.picUrl,
                width: 80,
                height: 80,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
