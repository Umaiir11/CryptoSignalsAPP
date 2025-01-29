class CryptoCoinsResponse {
  List<String>? coins;

  CryptoCoinsResponse({this.coins});

  factory CryptoCoinsResponse.fromJson(List<dynamic> json) {
    return CryptoCoinsResponse(
      coins: json.map((e) => e as String).toList(),
    );
  }

  List<dynamic> toJson() {
    return coins ?? [];
  }
}
