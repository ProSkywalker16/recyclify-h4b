import 'package:flutter/material.dart';
import 'package:recyclify/services/database.dart';
import 'package:recyclify/components/nearby_stores_map.dart';

class ConfirmationPage extends StatelessWidget {
  final String? selectedRAM;
  final String? selectedSSD;
  final String? selectedHDD;
  final String? selectedGPU;
  final String? selectedWarranty;
  final String? selectedOS;
  final String age;
  final String? selectedworkingCondition;
  final String? scratches;
  final String? batteryCondition;

  const ConfirmationPage({
    Key? key,
    this.selectedRAM,
    this.selectedSSD,
    this.selectedHDD,
    this.selectedGPU,
    this.selectedWarranty,
    this.selectedOS,
    required this.age,
    this.selectedworkingCondition,
    this.scratches,
    this.batteryCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Device Specifications Table
              Table(
                border: TableBorder.all(),
                children: [
                  _buildTableRow('Device Type', 'Laptop'),
                  _buildTableRow('RAM', selectedRAM ?? 'N/A'),
                  _buildTableRow('Age of the device', age),
                  _buildTableRow('SSD', selectedSSD ?? 'N/A'),
                  _buildTableRow('HDD', selectedHDD ?? 'N/A'),
                  _buildTableRow('GPU', selectedGPU ?? 'N/A'),
                  _buildTableRow('Warranty', selectedWarranty ?? 'N/A'),
                  _buildTableRow('Operating System', selectedOS ?? 'N/A'),
                  _buildTableRow('Working Condition', selectedworkingCondition ?? 'N/A'),
                  _buildTableRow('Battery Condition', batteryCondition ?? 'N/A'),
                ],
              ),
              const SizedBox(height: 20),

              // Map Section
              const Text(
                'Nearby Stores Offering Exchange/Sell Options:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),

              // Use SizedBox to ensure map does not take full space
              SizedBox(
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const NearbyStoresMap(),
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Button
              ElevatedButton(
                onPressed: () async {
                  await databaseService.storeDeviceData(
                    selectedRAM: selectedRAM,
                    selectedSSD: selectedSSD,
                    selectedHDD: selectedHDD,
                    selectedGPU: selectedGPU,
                    selectedWarranty: selectedWarranty,
                    selectedOS: selectedOS,
                    selectedworkingCondition: selectedworkingCondition,
                    age: age,
                    batteryCondition: batteryCondition,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Device data stored successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
}