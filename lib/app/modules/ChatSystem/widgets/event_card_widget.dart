import 'dart:convert';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:intl/intl.dart';

class EventCardWidget extends StatelessWidget {
  final String messageId;
  final String eventData;
  final bool isMine;
  final bool isResponding;
  final int currentUserId;
  final int receiverUserId;
  final Function(String response) onRespond;

  const EventCardWidget({
    super.key,
    required this.messageId,
    required this.eventData,
    required this.isMine,
    required this.isResponding,
    required this.currentUserId,
    required this.receiverUserId,
    required this.onRespond,
  });

  Map<String, dynamic> _parseEventData() {
    try {
      final decoded = jsonDecode(eventData);
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (e) {
      return {};
    }
  }

  String _formatDate(String date) {
    try {
      final dateTime = DateTime.parse(date);
      return DateFormat('EEE, MMM d, y').format(dateTime);
    } catch (e) {
      return date;
    }
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final period = hour >= 12 ? 'PM' : 'AM';
        final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '$hour12:${minute.toString().padLeft(2, '0')} $period';
      }
      return time;
    } catch (e) {
      return time;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Widget _buildStatusBadge(String status, bool isMine) {
    final color = _getStatusColor(status);
    final text = status.capitalizeFirst ?? status;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(text, style: MyTexts.bold12.copyWith(color: color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = _parseEventData();
    final title = (event['title'] ?? 'Event') as String;
    final description = (event['description'] ?? '') as String;
    final date = (event['date'] ?? '') as String;
    final time = (event['time'] ?? '') as String;
    final status = (event['status'] ?? 'pending') as String;
    final respondedByUserId = event['responded_by_user_id'];

    final isReceiver = currentUserId == receiverUserId;
    final isPending = status.toLowerCase() == 'pending';
    final canRespond = isReceiver && isPending && !isMine;
    final didIRespond = respondedByUserId == currentUserId;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMine ? Colors.white.withValues(alpha: 0.2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMine
              ? Colors.white.withValues(alpha: 0.3)
              : MyColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with calendar icon and status
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.event,
                  color: isMine ? Colors.white : MyColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: MyTexts.bold16.copyWith(
                    color: isMine ? Colors.white : Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildStatusBadge(status, isMine),
            ],
          ),

          const SizedBox(height: 12),

          // Date and Time
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: isMine ? Colors.white70 : Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(date),
                style: MyTexts.medium14.copyWith(
                  color: isMine ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: isMine ? Colors.white70 : Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                _formatTime(time),
                style: MyTexts.medium14.copyWith(
                  color: isMine ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),

          // Description (if provided)
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              description,
              style: MyTexts.regular14.copyWith(
                color: isMine ? Colors.white70 : Colors.black54,
              ),
            ),
          ],

          // Action buttons (for receiver only when pending)
          if (canRespond) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isResponding
                        ? null
                        : () => onRespond('accepted'),
                    icon: isResponding
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check, size: 18),
                    label: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isResponding
                        ? null
                        : () => onRespond('rejected'),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Show response note if user responded
          if (didIRespond && !isPending) ...[
            const SizedBox(height: 8),
            Text(
              status.toLowerCase() == 'accepted'
                  ? '✓ You accepted this event'
                  : '✗ You rejected this event',
              style: MyTexts.regular12.copyWith(
                color: isMine ? Colors.white70 : Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
