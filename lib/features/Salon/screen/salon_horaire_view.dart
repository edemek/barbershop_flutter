import 'package:flutter/material.dart';

class SalonAvailabilityFormView extends StatefulWidget {
  @override
  _SalonAvailabilityFormViewState createState() => _SalonAvailabilityFormViewState();
}

class _SalonAvailabilityFormViewState extends State<SalonAvailabilityFormView> {
  String? _selectedDay;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _notes;

  Future<void> _selectDay(BuildContext context) async {
    final List<String> days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Choisir le jour'),
        children: days.map((day) =>
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, day),
              child: Text(day),
            )
        ).toList(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedDay = result;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDaySelector(context),
        SizedBox(height: 16),
        _buildTimeSelector(context),
        SizedBox(height: 16),
        _buildNotesField(),
      ],
    );
  }

  Widget _buildDaySelector(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Sélectionner un jour'),
        subtitle: Text(_selectedDay ?? 'Aucun jour sélectionné'),
        trailing: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDay(context),
        ),
      ),
    );
  }

  Widget _buildTimeSelector(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('Heure de début'),
            subtitle: Text(_startTime != null
                ? _startTime!.format(context)
                : 'Aucune heure de début'),
            trailing: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => _selectStartTime(context),
            ),
          ),
        ),
        SizedBox(height: 16),
        Card(
          child: ListTile(
            title: Text('Heure de fin'),
            subtitle: Text(_endTime != null
                ? _endTime!.format(context)
                : 'Aucune heure de fin'),
            trailing: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => _selectEndTime(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Notes',
        border: OutlineInputBorder(),
        hintText: 'Ajouter des notes pour cette disponibilité',
      ),
      onChanged: (value) {
        setState(() {
          _notes = value;
        });
      },
      maxLines: 3,
    );
  }
}