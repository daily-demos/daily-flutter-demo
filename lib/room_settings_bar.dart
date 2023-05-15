import 'dart:async';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/logging.dart';
import 'package:daily_flutter_demo/room_parameters_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CallAction { join, leave }

class RoomSettingsBar extends StatefulWidget {
  const RoomSettingsBar({super.key, required this.client, required this.prefs});

  final CallClient client;
  final SharedPreferences prefs;

  @override
  State<RoomSettingsBar> createState() => _RoomSettingsBarState();
}

class _RoomSettingsBarState extends State<RoomSettingsBar> {
  StreamSubscription? _eventSubscription;
  bool _isLoading = false;
  CallAction _action = CallAction.join;
  late Uri? _url = (() {
    final previous = widget.prefs.getStringList('roomUrls')?.firstOrNull;
    if (previous == null || previous.isEmpty) {
      return null;
    }
    return Uri.tryParse(previous);
  })();
  String? _token;

  @override
  void initState() {
    super.initState();
    _eventSubscription = widget.client.events.listen(_handleEvent);
  }

  void _handleEvent(Event event) {
    if (!mounted) return;
    event.whenOrNull(
      callStateUpdated: (stateData) {
        if (mounted) {
          final state = stateData.state;
          setState(() {
            _isLoading = state == CallState.joining || state == CallState.leaving;
            if (state == CallState.left) {
              _action = CallAction.join;
            } else if (state == CallState.joined) {
              _action = CallAction.leave;
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final url = _url;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return GestureDetector(
      onTap: widget.client.callState != CallState.initialized && widget.client.callState != CallState.left
          ? null
          : () async {
              final previous = widget.prefs.getStringList('roomUrls') ?? [];
              final parameters = await showRoomParametersBottomSheet(
                context,
                previous.map(Uri.tryParse).whereNotNull(),
                _token,
              );
              if (parameters != null) {
                final urlStr = parameters.roomUrl.toString();
                final updatedUrls = [urlStr, ...previous.whereNot((it) => it == urlStr).take(9)];
                unawaited(widget.prefs.setStringList('roomUrls', updatedUrls));
                setState(() {
                  _url = parameters.roomUrl;
                  _token = parameters.token;
                });
              }
            },
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    url?.toString().replaceFirst(RegExp('^.*://'), '') ?? 'example.daily.co/room',
                    style: url == null
                        ? theme.textTheme.bodyMedium
                        : theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_token != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Token:', style: bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            _token ?? '',
                            style: bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: _isLoading || url == null
                  ? null
                  : () async {
                      setState(() => _isLoading = true);
                      try {
                        await (_action == CallAction.join
                            ? widget.client.join(url: url, token: _token)
                            : widget.client.leave());
                      } on DailyException catch (error, trace) {
                        logger.severe('Failed to ${_action.name} call', error, trace);
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      }
                    },
              child: _isLoading
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(
                      _action == CallAction.join ? 'Join' : 'Leave',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
