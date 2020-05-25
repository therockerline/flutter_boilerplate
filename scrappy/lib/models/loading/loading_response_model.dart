class LoadingResponseStatus {
  String status; // OK

  LoadingResponseStatus({this.status});

  factory LoadingResponseStatus.fromJson(Map<String, dynamic> json) {
    return LoadingResponseStatus(
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}