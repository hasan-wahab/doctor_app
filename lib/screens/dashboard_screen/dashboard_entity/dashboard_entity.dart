import '../../../data/models/current_patient_model.dart';

class DashboardEntity {
  DashboardHeaderEntity headerEntity;
  BalanceCardEntity balanceCardEntity;
  QuickOverviewEntity quickOverviewEntity;
  List<SessionProgressEntity> sessionProgressEntity;

  DashboardEntity({
    required this.headerEntity,
    required this.balanceCardEntity,
    required this.quickOverviewEntity,
    required this.sessionProgressEntity,
  });
}

/// Dashboard Header
class DashboardHeaderEntity {
  final String patientName;
  final String imageUrl;
  final String dateNow;
  DashboardHeaderEntity({
    required this.patientName,
    required this.imageUrl,
    required this.dateNow,
  });
}

/// Balance Card Entity
class BalanceCardEntity {
  final String currentBalance;
  final double total;
  final double paid;
  final double remaining;
  final double discount;
  final double insurance;
  final double progressPercent;
  BalanceCardEntity({
    required this.currentBalance,
    required this.total,
    required this.paid,
    required this.remaining,
    required this.discount,
    required this.insurance,
    required this.progressPercent,
  });
}

/// Quick Overview Entity

class QuickOverviewEntity {
  final String visits;
  final String activePackages;
  final String assessments;
  final String invoice;
  final String sessions;
  QuickOverviewEntity({
    required this.visits,
    required this.activePackages,
    required this.assessments,
    required this.invoice,
    required this.sessions,
  });
}

///  Session Progress Entity
class SessionProgressEntity {
  final String title;
  final String progressLabel;
  final int completedSessions;
  final int totalSessions;
  final String nextSessionLabel;
  final String nextSessionDate;

  SessionProgressEntity({
    required this.title,
    required this.progressLabel,
    required this.completedSessions,
    required this.totalSessions,
    required this.nextSessionLabel,
    required this.nextSessionDate,
  });
}

extension CurrentPatientDashboardMapper on CurrentPatientModel {
  DashboardEntity toDashboardEntity() {
    final patient = this.patient;
    final stats = this.stats;

    final patientName = patient?.displayName ?? '';
    final patientImageUrl = patient?.displayImageUrl ?? '';
    final total = stats?.totalAmount ?? 0;
    final paid = stats?.totalSpend ?? 0;
    final remaining = stats?.remaining ?? 0;
    final discount = stats?.totalDiscount ?? 0;
    final insurance = stats?.totalInsuranceDiscount ?? 0;
    final currentBalance = patient?.displayWalletBalance;

    /// Quick Overview
    final totalVisits = patient?.visits.length ?? 0;
    final activePackages = patient?.packages.length ?? 0;
    final invoice = patient?.packages.length ?? 0;
    final sessions = therapySessions.length;

    final progressPercent = total > 0 ? (paid / total) * 100 : 0.0;

    /// Session Progress
    final totalPackages = patient?.packages.length ?? 0;
    final package = patient?.packages;

    return DashboardEntity(
      headerEntity: DashboardHeaderEntity(
        patientName: patientName,
        imageUrl: patientImageUrl,
        dateNow: DateTime.now().toString(),
      ),
      balanceCardEntity: BalanceCardEntity(
        currentBalance: currentBalance ?? '',
        total: total,
        paid: paid,
        remaining: remaining,
        discount: discount,
        insurance: insurance,
        progressPercent: progressPercent,
      ),
      quickOverviewEntity: QuickOverviewEntity(
        visits: totalVisits.toString(),
        activePackages: activePackages.toString(),
        invoice: invoice.toString(),
        sessions: sessions.toString(),
        assessments: '',
      ),
      sessionProgressEntity: List.generate(totalPackages, (index) {
        return SessionProgressEntity(
          title: package?[index].displayName ?? '',
          progressLabel: 'Progress',
          completedSessions: package?[index].pivot?.sessionsUsed ?? 0,
          totalSessions: package?[index].sessions ?? 0,
          nextSessionLabel: 'Next Session',
          nextSessionDate: therapySessions[index].displayNextSessionDate,
        );
      }),
    );
  }
}
