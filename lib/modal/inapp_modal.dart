import 'package:meta/meta.dart';

@immutable
class InAppModal {
  final String id;
  final String title;
  final String subtitle;

  final String share;
  final String deeplink;

  const InAppModal({
    this.deeplink,
    this.id,
    this.share,
    this.subtitle,
    this.title,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'share': share,
        'deeplink': deeplink,
      };

  factory InAppModal.fromJson(Map<String, dynamic> json) => InAppModal(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        share: json['share'] as String,
        deeplink: json['deeplink'] as String,
      );
}
