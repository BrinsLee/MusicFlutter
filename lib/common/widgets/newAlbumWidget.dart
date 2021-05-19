import 'package:flutter/material.dart';
import 'package:music_flutter/common/models/album/newest_album.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/common/widgets/new_album_item_widget.dart';
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
    return NewAlbumItemWidget(album, start: index, end: index + 3);
  }

  @override
  bool get wantKeepAlive => true;
}
