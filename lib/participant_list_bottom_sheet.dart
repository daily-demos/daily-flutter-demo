import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';

Future<void> showParticipantListBottomSheet(
  BuildContext context,
  CallClient client,
  ValueNotifier<List<ParticipantId>> participantsUpdatedNotifier,
) =>
    showModalBottomSheet(
      context: context,
      builder: (_) => ParticipantListBottomSheet(
        client: client,
        participantsUpdatedNotifier: participantsUpdatedNotifier,
      ),
    );

class ParticipantListBottomSheet extends StatelessWidget {
  const ParticipantListBottomSheet({super.key, required this.client, required this.participantsUpdatedNotifier});

  final CallClient client;
  final ValueNotifier<List<ParticipantId>> participantsUpdatedNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onSurface.withOpacity(0.4);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Other participants', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: participantsUpdatedNotifier,
            builder: (context, _) {
              final participants = participantsUpdatedNotifier.value.expand((participantId) sync* {
                final participant = client.participants.all[participantId];
                if (participant != null) {
                  yield participant;
                }
              });
              return ListView.separated(
                shrinkWrap: true,
                itemCount: participants.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final participant = participants.elementAt(index);
                  return Row(
                    children: [
                      Text(
                        participant.info.username ?? 'Guest',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      if (participant.isCameraMuted) Icon(Icons.videocam_off, color: iconColor),
                      if (participant.isMicrophoneMuted) ...[
                        if (participant.isCameraMuted) const SizedBox(width: 4),
                        Icon(Icons.mic_off, color: iconColor),
                      ],
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
