class PUserModel {
  String? uid;
  String? name;
  String? dob;
  String? bloodgroup;
  String? gender;
  String? place;
  String? address;
  String? image;
  int? wallet;

  PUserModel(
      {required this.uid,
      required this.dob,
      required this.name,
      required this.bloodgroup,
      required this.gender,
      required this.address,
      required this.place,
      this.wallet,
      this.image});

  factory PUserModel.fromMap(map) {
    return PUserModel(
      wallet: map['Wallet'],
      uid: map['uid'],
      name: map['name'],
      dob: map['dob'],
      gender: map['gender'],
      bloodgroup: map['bloodgroup'],
      address: map['address'],
      place: map['place'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Wallet': wallet,
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

class DoctorModel {
  String? uid;
  String? name;
  String? category;

  String? image;

  DoctorModel(
      {required this.uid,
      required this.category,
      required this.name,
      this.image});

  factory DoctorModel.fromMap(map) {
    return DoctorModel(
        uid: map['uid'],
        name: map['name'],
        category: map['category'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'category': category,
      'image': image,
    };
  }
}
