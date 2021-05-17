import 'package:flutter/material.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/view_model/home_view_model.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class PersonalizedMusicListWidget extends StatefulWidget {
  final PersonalizedMusicViewModel _musicViewModel;

  PersonalizedMusicListWidget(this._musicViewModel);

  @override
  _PersonalizedMusicListWidgetState createState() =>
      _PersonalizedMusicListWidgetState(_musicViewModel);
}

class _PersonalizedMusicListWidgetState
    extends State<PersonalizedMusicListWidget> {
  final PersonalizedMusicViewModel _musicViewModel;

  _PersonalizedMusicListWidgetState(this._musicViewModel);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersonalizedMusicListResult listResult = _musicViewModel.listResult;
    return (_musicViewModel.listResult != null ||
            _musicViewModel.state == ViewState.dataFetchState)
        ? Container(
            height: 150,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listResult.result.length,
              itemBuilder: (context, index) {
                return _createItem(listResult.result[index]);
              },
            ),
          )
        : PKCardPageSkeleton(
            totalLines: 1,
          );
  }

  Widget _createItem(PersonalizedMusicList musicList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/base_icon_default_cover.png",
              image: musicList.picUrl,
              width: 120,
              height: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: 120,
              child: Text(
                musicList.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ))
      ],
    );
  }
}
