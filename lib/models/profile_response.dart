class ProfileResponse {
  String? id;
  String? username;
  String? name;
  String? email;

  ProfileResponse({this.id, this.name, this.email, this.username});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id']?.toString(), // Convert id to string (if not null)
      username: json['username']
          as String?, // Ensure name is explicitly cast to String
      name: json['name'] as String?, // Ensure name is explicitly cast to String
      email:
          json['email'] as String?, // Ensure email is explicitly cast to String
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> profileData = {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
    };
    return profileData;
  }
}
