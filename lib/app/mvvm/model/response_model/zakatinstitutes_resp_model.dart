class InstitutesResponse {
  final List<Institute> institutes;
  final Pagination pagination;

  InstitutesResponse({
    required this.institutes,
    required this.pagination,
  });

  factory InstitutesResponse.fromJson(Map<String, dynamic> json) {
    return InstitutesResponse(
      institutes: (json['institutes'] as List)
          .map((institute) => Institute.fromJson(institute))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institutes': institutes.map((institute) => institute.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class Institute {
  final int id;
  final String name;
  final String type;
  final String url;
  final String profilePic;

  Institute({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.profilePic,
  });

  factory Institute.fromJson(Map<String, dynamic> json) {
    return Institute(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      url: json['url'],
      profilePic: json['profile_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'profile_pic': profilePic,
    };
  }
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final String firstPageUrl;
  final String lastPageUrl;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.firstPageUrl,
    required this.lastPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
      'next_page_url': nextPageUrl,
      'prev_page_url': prevPageUrl,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
    };
  }
}
