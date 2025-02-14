import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';

class StatusUpdateConfig {
  final String nextStatus;
  final bool requiresAction;
  final String actionLabel;
  final IconData actionIcon;
  final bool requiresPhoto;
  final bool requiresNotes;
  final String? notePrompt;

  const StatusUpdateConfig({
    required this.nextStatus,
    required this.requiresAction,
    required this.actionLabel,
    required this.actionIcon,
    required this.requiresPhoto,
    required this.requiresNotes,
    this.notePrompt,
  });
}

class StatusUpdateDialog extends StatefulWidget {
  final String currentStatus;
  final StatusUpdateConfig config;
  final ImagePicker imagePicker;

  const StatusUpdateDialog({
    Key? key,
    required this.currentStatus,
    required this.config,
    required this.imagePicker,
  }) : super(key: key);

  @override
  _StatusUpdateDialogState createState() => _StatusUpdateDialogState();
}

class _StatusUpdateDialogState extends State<StatusUpdateDialog> {
  String? photoPath;
  final TextEditingController notesController = TextEditingController();

  // ...existing methods...

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // ...existing dialog content...
          title: Text(
            AppLocalizations.of(context)!.confirm(widget.config.actionLabel),
            style: TextStyle(color: Colors.blue)
          ),
      // ...rest of existing code...
    );
  }
}
