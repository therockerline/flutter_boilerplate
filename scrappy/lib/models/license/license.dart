class License {
  final String company_name;
  final String piva;
  final String hash;

  License(this.company_name, this.piva, this.hash,);

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      json['company_name'] as String,
      json['piva']  as String,
      json['hash']  as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.company_name;
    data['piva'] = this.piva;
    data['hash'] = this.hash;
    return data;
  }
}