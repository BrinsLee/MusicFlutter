import 'package:music_flutter/common/api/api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => BannerApi()),
  Provider(create: (_) => PersonalizedApi())
];
