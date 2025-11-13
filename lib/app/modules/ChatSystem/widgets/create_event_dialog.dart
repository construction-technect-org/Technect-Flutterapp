import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:intl/intl.dart';

class CreateEventDialog extends StatefulWidget {
  final Function({
    required String title,
    required String date,
    required String time,
    String? description,
  })
  onSend;

  const CreateEventDialog({super.key, required this.onSend});

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('EEE, MMM d, y').format(picked);
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

  String _formatDateForBackend() {
    if (selectedDate == null) return '';
    return DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  String _formatTimeForBackend() {
    if (selectedTime == null) return '';
    final hour = selectedTime!.hour.toString().padLeft(2, '0');
    final minute = selectedTime!.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool _validateForm() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter event title',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (selectedDate == null) {
      Get.snackbar(
        'Error',
        'Please select event date',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (selectedTime == null) {
      Get.snackbar(
        'Error',
        'Please select event time',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void _handleSend() {
    if (!_validateForm()) return;

    widget.onSend(
      title: titleController.text.trim(),
      date: _formatDateForBackend(),
      time: _formatTimeForBackend(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MyColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.event,
                      color: MyColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Create Event Invitation',
                      style: MyTexts.bold18.copyWith(color: MyColors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Title
              CommonTextField(
                controller: titleController,
                hintText: "Event title",
                headerText: "Title",
                isRed: true,
                prefixIcon: const Icon(Icons.title, color: MyColors.primary),
              ),

              const SizedBox(height: 16),

              // Date
              CommonTextField(
                controller: dateController,
                hintText: "Select date",
                headerText: "Date",
                isRed: true,
                readOnly: true,
                onTap: _selectDate,
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: MyColors.primary,
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),

              const SizedBox(height: 16),

              // Time
              CommonTextField(
                controller: timeController,
                hintText: "Select time",
                headerText: "Time",
                isRed: true,
                readOnly: true,
                onTap: _selectTime,
                prefixIcon: const Icon(
                  Icons.access_time,
                  color: MyColors.primary,
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),

              const SizedBox(height: 16),

              // Description (optional)
              CommonTextField(
                controller: descriptionController,
                hintText: "Add description (optional)",
                headerText: "Description",
                maxLine: 3,
                prefixIcon: const Icon(
                  Icons.description,
                  color: MyColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              // Send button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handleSend,
                  icon: const Icon(Icons.send),
                  label: const Text('Send Event Invitation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
