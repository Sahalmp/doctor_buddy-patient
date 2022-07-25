class Appointment {
  String? uid;
  String? hospital;
  int? date;
  int? token;
  String? timing;
  String? reason;

  Appointment(
      {this.uid,
      this.hospital,
      this.date,
      this.token,
      this.timing,
      this.reason});

  factory Appointment.fromMap(map) {
    return Appointment(
        uid: map['uid'],
        hospital: map['hospital'],
        date: map['date'],
        token: map['token'],
        timing: map['timing'],
        reason: map['reason']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'hospital': hospital,
      'date': date,
      'token': token,
      'timing': timing,
      'reason': reason
    };
  }
}
