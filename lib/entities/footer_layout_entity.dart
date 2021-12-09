import 'dart:convert';

import 'footer_entity.dart';
import 'utils/utils.dart';

class FooterLayoutEntity {
  const FooterLayoutEntity({
    this.layoutDirection = 'row',
    this.footerContent,
  });

  factory FooterLayoutEntity.fromJson(Map<String, dynamic> jsonRes) {
    final List<FooterEntity>? footerContent =
        jsonRes['content'] is List ? <FooterEntity>[] : null;
    if (footerContent != null) {
      for (final dynamic item in jsonRes['content']!) {
        if (item != null) {
          tryCatch(() {
            footerContent
                .add(FooterEntity.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FooterLayoutEntity(
      layoutDirection: asT<String?>(jsonRes['layout_direction']) ?? 'row',
      footerContent: footerContent,
    );
  }

  final String layoutDirection;
  final List<FooterEntity>? footerContent;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'layout_direction': layoutDirection,
        'content': footerContent?.map((e) => e.toJson()).toList(),
      };

  FooterLayoutEntity copy() {
    return FooterLayoutEntity(
      layoutDirection: layoutDirection,
      footerContent: footerContent?.map((e) => e.copy()).toList(),
    );
  }
}
