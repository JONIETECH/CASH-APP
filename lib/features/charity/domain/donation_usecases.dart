import 'package:finance_tracker/features/charity/domain/donation.dart';


class DonationUseCases {
  final DonationRepository donationRepository = DonationRepository();

  Future<void> saveDonationDetails(double goal, double total, List<Donation> donations) async {
    await donationRepository.saveDonationDetails(goal, total, donations);
  }
}
//needs fixing
class DonationRepository {
  saveDonationDetails(double goal, double total, List<Donation> donations) {}
  
  }



