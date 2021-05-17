import 'package:flutter/material.dart';
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
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.0),
                itemCount: album?.length ?? 0,
                itemBuilder: (context, index) {
                  return Text(
                    "${album[0].name}",
                    style: TextStyle(color: Colors.black),
                  );
                }),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          )
        : Container();
  }

  @override
  bool get wantKeepAlive => true;
}
