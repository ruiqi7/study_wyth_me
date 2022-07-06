class AppUser {

  final String uid;
  final String username;
  final Map<String, dynamic> map; // stores module : minutes in this format
  final String url;
  final dynamic points;
  final dynamic duration;
  final List<dynamic> friendsId;
  final List<dynamic> friendRequestsSent;
  final List<dynamic> friendRequestsReceived;
  final Map<String, dynamic> mythics;

  AppUser({
    required this.uid,
    required this.username,
    required this.map,
    required this.url,
    required this.points,
    required this.duration,
    required this.friendsId,
    required this.friendRequestsSent,
    required this.friendRequestsReceived,
    required this.mythics,
  });

  int compareTo(AppUser user) {
    if (points < user.points) {
      return -1;
    } else if (points > user.points) {
      return 1;
    } else {
      return 0;
    }
  }
}