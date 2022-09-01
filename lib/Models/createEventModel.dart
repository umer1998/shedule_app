

class CreateEventModel {
  String? eventName;
  String? startDate;
  String? endDate;
  String? description;
  String? colors;
  String? bg;
  String? uid;
  String? location;

  List<String>? tags;

  CreateEventModel( String eventName,
  String startDate, String endDate, String description, String colors,String bg,String uid,String location, List<String> tags){
    this.eventName = eventName;
    this.startDate= startDate;
    this.endDate = endDate;
    this.description = description;
    this.colors = colors;
    this.bg = bg;
    this.uid = uid;
    this.location = location;
    this.tags = tags;
  }



  CreateEventModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    colors = json['colors'];
    bg = json['bg'];
    uid = json['uid'];
    location = json['location'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventName'] = this.eventName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['colors'] = this.colors;
    data['bg'] = this.bg;
    data['uid'] = this.uid;
    data['location'] = this.location;
    data['tags'] = this.tags;
    return data;
  }
}
