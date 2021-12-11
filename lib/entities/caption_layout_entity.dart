import 'dart:convert';

import 'caption_entity.dart';
import 'utils/utils.dart';

class CaptionLayoutEntity {
  const CaptionLayoutEntity({
    this.layoutDirection = 'row',
    this.mainCaption,
    this.subCaption,
  });

  factory CaptionLayoutEntity.fromJson(Map<String, dynamic> jsonRes) =>
      CaptionLayoutEntity(
        layoutDirection: asT<String?>(jsonRes['layout_direction']) ?? 'row',
        mainCaption: jsonRes['main_caption'] == null
            ? null
            : CaptionEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['main_caption'])!),
        subCaption: jsonRes['sub_caption'] == null
            ? null
            : CaptionEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['sub_caption'])!),
      );

  final String layoutDirection;
  final CaptionEntity? mainCaption;
  final CaptionEntity? subCaption;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'layout_direction': layoutDirection,
        'main_caption': mainCaption?.toJson(),
        'sub_caption': subCaption?.toJson(),
      };

  CaptionLayoutEntity copy() {
    return CaptionLayoutEntity(
      layoutDirection: layoutDirection,
      mainCaption: mainCaption?.copy(),
      subCaption: subCaption?.copy(),
    );
  }

  bool get isFilled =>
      mainCaption != null &&
      mainCaption!.isFilled &&
      subCaption != null &&
      subCaption!.isFilled;
}
