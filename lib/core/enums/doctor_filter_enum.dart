// ignore_for_file: constant_identifier_names

enum DoctorFilterEnum {
  rating,
  consultation_fee,
  average_waiting_time,
}

extension DoctorFilterExtension on DoctorFilterEnum {
  String get text {
    switch (this) {
      case DoctorFilterEnum.rating:
        return 'Rating';
      case DoctorFilterEnum.consultation_fee:
        return 'Consultation Fee';
      case DoctorFilterEnum.average_waiting_time:
        return 'Average Waiting Time';
      }
  }
}
