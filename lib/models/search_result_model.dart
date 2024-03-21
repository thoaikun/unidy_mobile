import 'dart:convert';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';

SearchResult searchResultFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  int totals;
  List<dynamic> hits;

  SearchResult({
    required this.totals,
    required this.hits,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    totals: json["totals"],
    hits: List<dynamic>.from(json["hits"].map((x) {
      if (x['campaign'] != null) {
        return CampaignPost.fromJson(x);
      }
      else if (x['postId'] != null) {
        return Post.fromJson(x);
      }
      else if (x['userId'] != null) {
        return Friend.fromJson(x);
      }
    })),
  );

  Map<String, dynamic> toJson() => {
    "totals": totals,
    "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
  };
}