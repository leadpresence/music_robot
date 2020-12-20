import 'dart:convert';

import 'package:flutter/foundation.dart';
class MusicList {
  final List<Music> radios;
  MusicList({
    this.radios,
  });

  MusicList copyWith({
    List<Music> radios,
  }) {
    return MusicList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory MusicList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MusicList(
      radios: List<Music>.from(map['radios']?.map((x) => Music.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicList.fromJson(String source) =>
      MusicList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MusicList && listEquals(o.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class Music {
  final int id;
  final int order;

  final String name;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String image;
  final String lang;
  final String icon;
  final String category;
  final bool disliked;
  Music({
    this.id,
    this.name,
    this.tagline,
    this.color,
    this.desc,
    this.url,
    this.image,
    this.lang,
    this.icon,
    this.category,
    this.disliked,
    this.order,
  });

  Music copyWith({
    int id,
    int order,
    String name,
    String tagline,
    String color,
    String desc,
    String url,
    String image,
    String lang,
    String icon,
    String category,
    bool disliked,
  }) {
    return Music(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      image: image ?? this.image,
      lang: lang ?? this.lang,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      disliked: disliked ?? this.disliked,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'image': image,
      'lang': lang,
      'icon': icon,
      'category': category,
      'disliked': disliked,
      'order': order,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Music(
      id: map['id'],
      name: map['name'],
      tagline: map['tagline'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      image: map['image'],
      lang: map['lang'],
      icon: map['icon'],
      category: map['category'],
      disliked: map['disliked'],
      order: map['order'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) => Music.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Music(id: $id, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, image: $image, lang: $lang, icon: $icon, category: $category, disliked: $disliked, order: $order)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Music &&
        o.id == id &&
        o.name == name &&
        o.tagline == tagline &&
        o.color == color &&
        o.desc == desc &&
        o.url == url &&
        o.image == image &&
        o.lang == lang &&
        o.icon == icon &&
        o.category == category &&
        o.disliked == disliked &&
        o.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        color.hashCode ^
        desc.hashCode ^
        url.hashCode ^
        image.hashCode ^
        lang.hashCode ^
        icon.hashCode ^
        category.hashCode ^
        disliked.hashCode ^
        order.hashCode;
  }
}
