import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';





class CountryPickerScreen extends StatefulWidget {
  const CountryPickerScreen({super.key});

  @override
  CountryPickerScreenState createState() => CountryPickerScreenState();
}

class CountryPickerScreenState extends State<CountryPickerScreen> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختر الدولة")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedCountry ?? "لم يتم اختيار دولة",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true, // عرض كود الدولة مع الاسم
                  onSelect: (Country country) {
                    setState(() {
                      selectedCountry =
                          "${country.flagEmoji} ${country.name} (+${country.phoneCode})";
                    });
                  },
                );
              },
              child: const Text("اختر الدولة"),
            ),
          ],
        ),
      ),
    );
  }
}
