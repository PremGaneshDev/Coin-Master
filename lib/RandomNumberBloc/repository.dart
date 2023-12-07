import 'package:shared_preferences/shared_preferences.dart';

class RandomNumberRepository {
  static const String _successCountKey = 'successCount';

  Future<int> incrementSuccessCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(_successCountKey) ?? 0;
    int newCount = currentCount + 1;
    await prefs.setInt(_successCountKey, newCount);
    return newCount;
  }
}
