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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Device Specifications Table
            Table(
              border: TableBorder.all(),
              children: [
                const TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Device Type:'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Laptop'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('RAM'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedRAM ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Age of the device'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(age),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('SSD'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedSSD ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('HDD'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedHDD ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('GPU'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedGPU ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Warranty'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedWarranty ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Operating System'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedOS ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Working condition'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedworkingCondition ?? 'N/A'),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Battery Condition'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(batteryCondition ?? 'N/A'),
                  ),
                ]),
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
            
            // Map Widget
            Expanded(
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
    );
  }
}