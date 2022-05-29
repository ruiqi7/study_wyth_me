class AppUser {

  final String uid;
  final String username;
  final Map<String, dynamic> map; // stores module : minutes in this format
  final String url;
  final dynamic points;
  final dynamic duration;

  AppUser({
    required this.uid,
    required this.username,
    required this.map,
    required this.url,
    required this.points,
    required this.duration
  });
}