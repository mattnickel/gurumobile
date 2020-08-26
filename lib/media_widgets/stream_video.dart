import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StreamVideo extends StatefulWidget {
	StreamVideo({Key key}) : super(key:key);
	@override
	_StreamVideoState createState() => _StreamVideoState();
}

class _StreamVideoState extends State<StreamVideo>{

	VideoPlayerController _videoController;
	int _playbackTime = 0;
	double _volume = 0.5;

	void _initPlayer() async {
		_videoController = VideoPlayerController.asset(
				'/videos/background.mp4');
		await _videoController.initialize();
		setState((){});
	}
	@override
	void initState(){
		super.initState();
		_initPlayer();
		_videoController.addListener(() {
			setState(() {
			  _playbackTime = _videoController.value.position.inSeconds;
			  _volume = _videoController.value.volume;
			});
		});
	}

		@override
		void dispose() {
			_videoController.dispose();
			super.dispose();
		}

		@override
		Widget build(BuildContext context) {
		return
			_videoController.value.initialized ? _playerWidget() :Container();
		}

		Widget _playerWidget(){
			return Stack(
				children: <Widget>[
					Align(
						alignment: Alignment.bottomLeft,
						child: FloatingActionButton(
							onPressed:(){
									_videoController.value.isPlaying
									? _videoController.pause()
									: _videoController.play();
								setState((){});
							},
							child: _videoController.value.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
						),
					),
					Column(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment:MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.center,
						children:<Widget>[
							AspectRatio(
								aspectRatio: _videoController.value.aspectRatio,
								child: VideoPlayer(_videoController)
							),
							Slider(
								value:_playbackTime.toDouble(),
								max: _videoController.value.duration.inSeconds.toDouble(),
								min: 0,
								onChanged:(v){
									_videoController.seekTo(Duration(seconds: v.toInt()));
								},
								),
							Slider(
								value:_volume,
								max: 1,
								min: 0,
								onChanged:(v){
									_videoController.setVolume(v);
								},
							)
						],
					)
			]
			);
	}
}

