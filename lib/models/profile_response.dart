class ProfileResponse {
  String? id;
  String? name;
  String? email;

  ProfileResponse({this.id, this.name, this.email});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id']?.toString(), // Convert id to string (if not null)
      name: json['name'] as String?, // Ensure name is explicitly cast to String
      email:
          json['email'] as String?, // Ensure email is explicitly cast to String
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> profileData = {
      'id': id,
      'name': name,
      'email': email,
    };
    return profileData;
  }
}
