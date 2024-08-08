import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview_flutter/models/city.dart';
import 'package:interview_flutter/providers/city_provider.dart';
import 'package:provider/provider.dart';

class AddCityBottomSheet extends StatefulWidget {
  const AddCityBottomSheet({super.key});

  @override
  State<AddCityBottomSheet> createState() => _AddCityBottomSheetState();
}

class _AddCityBottomSheetState extends State<AddCityBottomSheet> {

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  City? _selectedCity;
  
  bool get _pressedButton { //valida si los textfield estan vacios o no.
    return _cityController.text.isNotEmpty && _descriptionController.text.isNotEmpty;
  }
  //Inicializamos
  @override
  void initState() {
    super.initState();
    _cityController.addListener(_checkFieldsFilled);
    _descriptionController.addListener(_checkFieldsFilled);
  }

  @override
  void dispose() {
    _cityController.removeListener(_checkFieldsFilled);
    _descriptionController.removeListener(_checkFieldsFilled);
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

   void _checkFieldsFilled() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Ajusta el problema de desbordamiento del teclado
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Lista de widgets para Add City - Description
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    width: 40.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _cityController,
                  onChanged: (value){
                    //Si colocamos una letra manda a llamar nuestro provider para que llame a la lista
                    if (value.isNotEmpty) {
                      Provider.of<CityProvider>(context, listen: false).fetchSuggestions(value);
                    } else {
                      Provider.of<CityProvider>(context, listen: false).clearSuggestions();
                    }
                  },
                  decoration: InputDecoration(
                    label: const Text('Add City'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: (){
                        _cityController.clear();
                        Provider.of<CityProvider>(context, listen: false).clearSuggestions();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                //Consumer para escuchar los cambios de nuestro provider
                Consumer<CityProvider>(
                  builder: (context, cityProvider, child){
                    // Verifica si la lista de sugerencias no está vacía
                    if(cityProvider.suggestions.isNotEmpty){
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cityProvider.suggestions.length,
                          itemBuilder: (context, index){
                            final city = cityProvider.suggestions[index];
                            return ListTile(
                              title: Text(city.localizedName),
                              onTap: () {
                              setState(() {
                                _selectedCity = city; // Establece la ciudad seleccionada
                                _cityController.text = city.localizedName; // Muestra el nombre de la ciudad seleccionada en el campo de texto
                              });
                              // Limpia las sugerencias después de seleccionar una ciudad
                              Provider.of<CityProvider>(context, listen: false).clearSuggestions();
                            },
                            );
                          }
                        ),
                      );  
                    }else{ 
                      // Si las sugerencias estan vacias no muestra nada
                      return Container();
                    }
                  }
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      label: const Text('Description'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: (){
                          _descriptionController.clear();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pressedButton ? Colors.blue : Colors.grey[600],
                      disabledBackgroundColor: Colors.grey[600],
                    ),   
                    onPressed: _pressedButton 
                      ? () {
                        if (_selectedCity != null) {
                          Provider.of<CityProvider>(context, listen: false).addCity(
                            _selectedCity!,
                            _descriptionController.text,
                          );
                          Navigator.pop(context);
                        }
                      }
                      : null,
                    child: Text('Save City',
                    style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}