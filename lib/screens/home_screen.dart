import 'package:flutter/material.dart';
import 'package:interview_flutter/providers/city_provider.dart';
import 'package:interview_flutter/widgets/add_city_bottom_sheet.dart';
import 'package:interview_flutter/widgets/bottom_navbar.dart';
import 'package:interview_flutter/widgets/city_cards.dart';
import 'package:interview_flutter/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset('assets/weather_icon.png', height: 24),
            const SizedBox(width: 10),
            const Text(
              'WeatherForemost',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Consumer<CityProvider>(
        builder: (context, cityProvider, child) {
          if (cityProvider.cities.isEmpty) {
            return const NoDataWidget();
          } else {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: cityProvider.cities.length,
                itemBuilder: (context, index) {
                  final city = cityProvider.cities[index];
                  return CityCard(city: city);
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        showModalBottomSheet(
          context: context, 
          isScrollControlled: true,
          builder: (BuildContext buildcontext){
            return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddCityBottomSheet(),
        );  
          });
      },
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
      ),
    );
  }
}