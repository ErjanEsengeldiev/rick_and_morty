import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/app_theme/text_helper.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';

class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Episode: ${episode.episode}',
              style: AppTextStyle.fS18FW400,
            ),
            Text(
              'AirDate: ${episode.airDate}',
              style: AppTextStyle.fS18FW400,
            ),
            Text(
              'Created: ${episode.created}',
              style: AppTextStyle.fS18FW400,
            ),
            Text(
              'url: ${episode.url}',
              style: AppTextStyle.fS18FW400,
            ),
          ],
        ),
      ),
    );
  }
}
