import 'dart:convert';

import 'package:meta/meta.dart';

class FriendListViewModel {
  FriendListViewModel({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.location,
  });

  final String avatar;
  final String name;
  final String email;
  final String location;

  static List<FriendListViewModel> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['results']
        .cast<Map<String, dynamic>>()
        .map((obj) => FriendListViewModel.fromMap(obj))
        .toList()
        .cast<FriendListViewModel>();
  }

  static FriendListViewModel fromMap(Map map) {
    var name = map['name'];

    return new FriendListViewModel(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      location: _capitalize(map['location']['state']),
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}

List<FriendListViewModel> available_friends= [
  FriendListViewModel(
    name: "kama",
    email: "kenn kamau",
    avatar: "assets/images/background.jpg",
    location: "Kenya"
  ),
    FriendListViewModel(
    name: "kak",
    email: "kaka man",
    avatar: "assets/images/avatar.jpg",
    location: "Tanzania"
  ),
    FriendListViewModel(
    name: "lwa",
    email: "aka@mail",
    avatar: "assets/images/kenn.jpg",
    location: "Uganda"
  ),

];