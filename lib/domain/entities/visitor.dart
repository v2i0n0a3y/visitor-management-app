import 'package:cloud_firestore/cloud_firestore.dart';

class Visitor {
  final String? id;
  final String? photoUrl;
  final String fullName;
  final String mobileNumber;
  final String? emailId;
  final String purposeOfVisit;
  final String companyName;
  final String personToVisit;
  final DateTime timeToMeet;
  final DateTime? timeToLeave;
  final bool hasReturned;
  final String watchmanEmail;

  Visitor({
    this.id,
    this.photoUrl,
    required this.fullName,
    required this.mobileNumber,
    this.emailId,
    required this.purposeOfVisit,
    required this.companyName,
    required this.personToVisit,
    required this.timeToMeet,
    this.timeToLeave,
    this.hasReturned = false,
    required this.watchmanEmail,
  });

  factory Visitor.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Visitor(
      id: doc.id,
      photoUrl: data['photoUrl'],
      fullName: data['fullName'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      emailId: data['emailId'],
      purposeOfVisit: data['purposeOfVisit'] ?? '',
      companyName: data['companyName'] ?? '',
      personToVisit: data['personToVisit'] ?? '',
      timeToMeet: (data['timeToMeet'] as Timestamp).toDate(),
      timeToLeave: (data['timeToLeave'] as Timestamp?)?.toDate(),
      hasReturned: data['hasReturned'] ?? false,
      watchmanEmail: data['watchmanEmail'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'photoUrl': photoUrl,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'emailId': emailId,
      'purposeOfVisit': purposeOfVisit,
      'companyName': companyName,
      'personToVisit': personToVisit,
      'timeToMeet': Timestamp.fromDate(timeToMeet),
      'timeToLeave': timeToLeave != null ? Timestamp.fromDate(timeToLeave!) : null,
      'hasReturned': hasReturned,
      'watchmanEmail': watchmanEmail,
    };
  }

  Visitor copyWith({
    String? id,
    String? photoUrl,
    String? fullName,
    String? mobileNumber,
    String? emailId,
    String? purposeOfVisit,
    String? companyName,
    String? personToVisit,
    DateTime? timeToMeet,
    DateTime? timeToLeave,
    bool? hasReturned,
    String? watchmanEmail,
  }) {
    return Visitor(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emailId: emailId ?? this.emailId,
      purposeOfVisit: purposeOfVisit ?? this.purposeOfVisit,
      companyName: companyName ?? this.companyName,
      personToVisit: personToVisit ?? this.personToVisit,
      timeToMeet: timeToMeet ?? this.timeToMeet,
      timeToLeave: timeToLeave ?? this.timeToLeave,
      hasReturned: hasReturned ?? this.hasReturned,
      watchmanEmail: watchmanEmail ?? this.watchmanEmail,
    );
  }
}

