import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/view_model/home_view_model.dart';

class NewAlbumWidget extends StatefulWidget {
  final NewestAlbumViewModel _albumViewModel;

  NewAlbumWidget(this._albumViewModel);

  @override
  _NewAlbumWidgetState createState() => _NewAlbumWidgetState(_albumViewModel);
}

class _NewAlbumWidgetState extends State<NewAlbumWidget>
    with AutomaticKeepAliveClientMixin {
  final NewestAlbumViewModel _albumViewModel;

  _NewAlbumWidgetState(this._albumViewModel);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NewestAlbum> album = _albumViewModel.newestAlbum?.albums;
    return (_albumViewModel.state == ViewState.dataFetchState)
        ? Container(
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 10),
                itemBuilder: (context, index) {
                  return _buildListItemWithIndex(album, index);
                }),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          )
        : Container();
  }

  Widget _buildListItemWithIndex(List<NewestAlbum> album, int index) {
    switch (index) {
      case 0:
        {
          return Container(
            width: MediaQuery.of(context).size.width - 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildListItem(album[0]),
                _buildListItem(album[1]),
                _buildListItem(album[2])
              ],
            ),
          );
          break;
        }
      case 1:
        {
          return Column(
            children: [
              _buildListItem(album[3]),
              _buildListItem(album[4]),
              _buildListItem(album[5])
            ],
          );
          break;
        }
      case 2:
        {
          return Column(
            children: [
              _buildListItem(album[6]),
              _buildListItem(album[7]),
              _buildListItem(album[8])
            ],
          );
          break;
        }
      case 3:
        {
          return Column(
            children: [
              _buildListItem(album[9]),
              _buildListItem(album[10]),
              _buildListItem(album[11])
            ],
          );
          break;
        }
      default:
        {
          return Container();
        }
    }
  }

  Widget _buildListItem(NewestAlbum album) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: MediaQuery.of(context).size.width - 80,
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
                width: MediaQuery.of(context).size.width - 100,
                height: 80,
                child: Text(
                  "${album.name}",
                  style: TextStyle(color: Colors.black),
                ),
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

  @override
  bool get wantKeepAlive => true;
}
