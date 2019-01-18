import 'dart:math';
import 'dart:core';
import 'dart:math';

class AppRandom {
/**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
  int randomNumber(int min, int max) {
    final _random = new Random();
    return min + _random.nextInt(max - min);
  }

  String randomString(int strlen) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}

