class AllTerapistModle {
  int? total;
  List<VisitWiseSessions>? visitWiseSessions;
  TypeHints? typeHints;

  AllTerapistModle({this.total, this.visitWiseSessions, this.typeHints});

  AllTerapistModle.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['visit_wise_sessions'] != null) {
      visitWiseSessions = <VisitWiseSessions>[];
      json['visit_wise_sessions'].forEach((v) {
        visitWiseSessions!.add(new VisitWiseSessions.fromJson(v));
      });
    }
    typeHints = json['type_hints'] != null
        ? new TypeHints.fromJson(json['type_hints'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.visitWiseSessions != null) {
      data['visit_wise_sessions'] =
          this.visitWiseSessions!.map((v) => v.toJson()).toList();
    }
    if (this.typeHints != null) {
      data['type_hints'] = this.typeHints!.toJson();
    }
    return data;
  }
}

class VisitWiseSessions {
  List<Sessions>? sessions;
  Summary? summary;

  VisitWiseSessions({this.sessions, this.summary});

  VisitWiseSessions.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    return data;
  }
}

class Sessions {
  int? sessionID;
  int? sessionNumber;
  String? packageUsed;
  String? therapist;
  String? activeTime;
  String? sessionDurationTotal;
  List<ModalitiesPerformed>? modalitiesPerformed;
  String? nextSessionDate;
  String? clinicalNotes;
  String? createdAt;

  Sessions(
      {this.sessionID,
        this.sessionNumber,
        this.packageUsed,
        this.therapist,
        this.activeTime,
        this.sessionDurationTotal,
        this.modalitiesPerformed,
        this.nextSessionDate,
        this.clinicalNotes,
        this.createdAt});

  Sessions.fromJson(Map<String, dynamic> json) {
    sessionID = json['Session ID'];
    sessionNumber = json['Session Number'];
    packageUsed = json['Package Used'];
    therapist = json['Therapist'];
    activeTime = json['Active Time'];
    sessionDurationTotal = json['Session Duration (Total)'];
    if (json['Modalities Performed'] != null) {
      modalitiesPerformed = <ModalitiesPerformed>[];
      json['Modalities Performed'].forEach((v) {
        modalitiesPerformed!.add(new ModalitiesPerformed.fromJson(v));
      });
    }
    nextSessionDate = json['Next Session Date'];
    clinicalNotes = json['Clinical Notes'];
    createdAt = json['Created At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Session ID'] = this.sessionID;
    data['Session Number'] = this.sessionNumber;
    data['Package Used'] = this.packageUsed;
    data['Therapist'] = this.therapist;
    data['Active Time'] = this.activeTime;
    data['Session Duration (Total)'] = this.sessionDurationTotal;
    if (this.modalitiesPerformed != null) {
      data['Modalities Performed'] =
          this.modalitiesPerformed!.map((v) => v.toJson()).toList();
    }
    data['Next Session Date'] = this.nextSessionDate;
    data['Clinical Notes'] = this.clinicalNotes;
    data['Created At'] = this.createdAt;
    return data;
  }
}

class ModalitiesPerformed {
  String? modality;
  String? duration;

  ModalitiesPerformed({this.modality, this.duration});

  ModalitiesPerformed.fromJson(Map<String, dynamic> json) {
    modality = json['Modality'];
    duration = json['Duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Modality'] = this.modality;
    data['Duration'] = this.duration;
    return data;
  }
}

class Summary {
  VisitSummary? visitSummary;

  Summary({this.visitSummary});

  Summary.fromJson(Map<String, dynamic> json) {
    visitSummary = json['Visit Summary'] != null
        ? new VisitSummary.fromJson(json['Visit Summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visitSummary != null) {
      data['Visit Summary'] = this.visitSummary!.toJson();
    }
    return data;
  }
}

class VisitSummary {
  int? visitID;
  String? visitDate;
  String? clinic;
  String? visitStatus;
  String? currentStage;

  VisitSummary(
      {this.visitID,
        this.visitDate,
        this.clinic,
        this.visitStatus,
        this.currentStage});

  VisitSummary.fromJson(Map<String, dynamic> json) {
    visitID = json['Visit ID'];
    visitDate = json['Visit Date'];
    clinic = json['Clinic'];
    visitStatus = json['Visit Status'];
    currentStage = json['Current Stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Visit ID'] = this.visitID;
    data['Visit Date'] = this.visitDate;
    data['Clinic'] = this.clinic;
    data['Visit Status'] = this.visitStatus;
    data['Current Stage'] = this.currentStage;
    return data;
  }
}

class TypeHints {
  List<String>? arrays;
  List<String>? strings;
  List<String>? integers;

  TypeHints({this.arrays, this.strings, this.integers});

  TypeHints.fromJson(Map<String, dynamic> json) {
    arrays = json['Arrays'].cast<String>();
    strings = json['Strings'].cast<String>();
    integers = json['Integers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Arrays'] = this.arrays;
    data['Strings'] = this.strings;
    data['Integers'] = this.integers;
    return data;
  }
}
