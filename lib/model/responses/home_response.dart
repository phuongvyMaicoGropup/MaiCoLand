import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';

class HomeResponse {
  List<News> news =[];
  List<LandPlanning> landPlannings=[];
  // List<Banner> banners;

  // List<Categoryy> categories;

  // @JsonKey(name: "recommended_seats")
  // List<Show> recommendedSeats;

  // @JsonKey(name: "nearby_theatres")
  // List<Cine> nearbyTheatres;

  // @JsonKey(name: "show_by_categories")
  // List<ShowByCategoryResponse> showByCategories;

  // HomeResponse({this.banners, this.categories});

  // factory HomeResponse.fromJson(Map<String, dynamic> json) =>
  //     _$HomeResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
