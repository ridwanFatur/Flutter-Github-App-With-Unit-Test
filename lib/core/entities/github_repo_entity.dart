class GithubRepoEntity {
  int id;
  String fullName;
  String avatarUrl;

  GithubRepoEntity({
    required this.id,
    required this.fullName,
    required this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "full_name": fullName,
      "avatar_url": avatarUrl,
    };
  }

  GithubRepoEntity copy() {
    return GithubRepoEntity(id: id, fullName: fullName, avatarUrl: avatarUrl);
  }

  factory GithubRepoEntity.fromMap(Map<String, dynamic> map) {
    return GithubRepoEntity(
      id: map["id"],
      fullName: map["full_name"],
      avatarUrl: map["owner"]["avatar_url"],
    );
  }
}
