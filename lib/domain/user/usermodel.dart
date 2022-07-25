class PUserModel {
  String? uid;
  String? name;
  String? dob;
  String? bloodgroup;
  String? gender;
  String? place;
  String? address;
  String? image;

  PUserModel(
      {required this.uid,
      required this.dob,
      required this.name,
      required this.bloodgroup,
      required this.gender,
      required this.address,
      required this.place,
      this.image});

  factory PUserModel.fromMap(map) {
    return PUserModel(
        uid: map['uid'],
        name: map['name'],
        dob: map['dob'],
        gender: map['gender'],
        bloodgroup: map['bloodgroup'],
        address: map['address'],
        place: map['place'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'gender': gender,
      'place': place,
      'dob': dob,
      'bloodgroup': bloodgroup,
      'address': address,
      'image': image,
    };
  }
}
