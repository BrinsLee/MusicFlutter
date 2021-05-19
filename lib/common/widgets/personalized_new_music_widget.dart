import 'package:flutter/material.dart';
import 'package:music_flutter/common/models/entities.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/view_model/home_view_model.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

/// Created by lipeilin
/// on 2021/2/5
class PersonalizedNewMusicWidget extends StatefulWidget {
  final PersonalizedMusicViewModel _musicViewModel;

  const PersonalizedNewMusicWidget(this._musicViewModel, {Key key})
      : super(key: key);

  @override
  _PersonalizedNewMusicWidgetState createState() =>
      _PersonalizedNewMusicWidgetState(_musicViewModel);
}

class _PersonalizedNewMusicWidgetState
    extends State<PersonalizedNewMusicWidget> {
  final PersonalizedMusicViewModel _musicViewModel;

  _PersonalizedNewMusicWidgetState(
      this._musicViewModel); // List<BaseMusic> _list = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersonalizedNewMusicResult musicResult = _musicViewModel.musicResult;
    return (_musicViewModel.musicResult != null &&
            _musicViewModel.state == ViewState.dataFetchState)
        ? Container(
            height: 150,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: musicResult.result.length,
              itemBuilder: (context, index) {
                return _createItem(musicResult.result[index]);
              },
            ),
          )
        : PKCardPageSkeleton(
            totalLines: 1,
          );
  }

  Widget _createItem(BaseMusic music) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/base_icon_default_cover.png",
                    image: music.picUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                    right: 1.0,
                    bottom: 1.0,
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/images/home_ic_play.png",
                        width: 50,
                        height: 50,
                      ),
                    ))
              ],
            )),
        Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: 120,
              child: Text(
                music.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ))
      ],
    );
  }
}
