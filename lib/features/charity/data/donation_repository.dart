import 'dart:io';
import 'package:finance_tracker/features/charity/domain/donation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';


class DonationRepository {
  Future<void> saveDonationDetails(double goal, double total, List<Donation> donations) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/donations.txt');

    String content = 'Donation Goal: \$$goal\n';
    content += 'Total Donations: \$$total\n';
    content += 'Donations:\n';

    for (var donation in donations) {
      final date = DateFormat('yyyy-MM-dd').format(donation.date);
      content += '\$${donation.amount} on $date\n';
    }

    await file.writeAsString(content);
    await FlutterFileDialog.saveFile(params: SaveFileDialogParams(sourceFilePath: file.path));
  }
}
