import 'package:finance_tracker/features/charity/data/donation_repository.dart';
import 'package:finance_tracker/features/charity/domain/donation.dart';


class DonationUseCases {
  final DonationRepository donationRepository = DonationRepository();

  Future<void> saveDonationDetails(double goal, double total, List<Donation> donations) async {
    await donationRepository.saveDonationDetails(goal, total, donations);
  }
}
class DonationRepository {
  saveDonationDetails(double goal, double total, List<Donation> donations) {}
  
  }



