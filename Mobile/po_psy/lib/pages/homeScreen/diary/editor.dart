
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:po_psy/api/api.dart';
import 'package:po_psy/constants/UIConstants/ColorPallet.dart';
import 'package:po_psy/constants/UIConstants/TextStyles.dart';
import 'package:po_psy/models/Record.dart';
import 'package:po_psy/widgets/LogoElement.dart';
import 'package:po_psy/pages/authorization/registration/registration.dart';
import 'package:po_psy/models/User.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';

import '../../../constants/UIConstants/ColorPallet.dart';


typedef _Fn = void Function();

class EditorPage extends StatefulWidget {
  Record record;
  EditorPage({this.record});

  @override
  _EditorPageState createState() => _EditorPageState(record: record);
}

class _EditorPageState extends State<EditorPage> {
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
bool _mPlayerIsInited = false;
bool _mRecorderIsInited = false;
bool _mplaybackReady = false;
final String _mPath = 'flutter_sound_example.aac';

Record record;
  _EditorPageState({this.record});
  String _text = '';

  @override
  void initState() {
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    textControler.addListener(_saveText);
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    _mPlayer = null;

    _mRecorder.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }
  DateTime _dateTime = DateTime.now();
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
    'Saturday', 'Sunday'];
  List<String> _current = ['14', '16', '18', '20', '22', '24'];
  String _currentSelectedValue = '14';
  bool _italic = false;
  bool _underline = false;
  bool _bold = false;
  final textControler = TextEditingController();

  _saveText(){
    _text = textControler.text;
  }

  void Myrecord() {
    _mRecorder
        .startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
        fromURI: _mPath,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.backgroundColor,
        body: Container(
            child: Center(
                child: new ListView(
                    children: <Widget>[
                      Stack(
                          children: <Widget>[
                            Container(
                              height: 45,
                              decoration: new BoxDecoration(color: ColorPallet.mainColor,),
                            ),
                            Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();                      },
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                  ),
                                )
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                  record == null ?
                                  "${week[_dateTime.weekday - 1]}, ${months[_dateTime.month - 1]} ${_dateTime.day}, ${_dateTime.year}"
                                      :"${week[record.Date.weekday - 1]}, ${months[record.Date.month - 1]} ${record.Date.day}, ${record.Date.year}",
                                  style: TextStyles.lightHeader2TextStyle
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, right: 30),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: Text('Done',
                                    style: TextStyles.lightHeader2TextStyle),
                                onTap: () {
                                  if(record != null)
                                    _dateTime = record.Date;
                                  Record newRecord = Record(_dateTime, _text);
                                  //to do------------------------------------------------------------------
                                },
                              ),
                            )
                          ]
                      ),
                      Container(
                          height: 240.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/image/defolt_diary.jpg")),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 350.0,
                              ),
                              child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        controller: textControler,
                                        onChanged: (String value) {
                                          _text = value;
                                        },
                                        onTap: (){
                                          textControler.text = record == null ? '' : record.type;
                                        },
                                        style: TextStyle(
                                          color: ColorPallet.mainTextColor,
                                          fontSize: double.tryParse(_currentSelectedValue),
                                          decoration: _underline ? TextDecoration.underline : TextDecoration.none,
                                          fontStyle: _italic ? FontStyle.italic : FontStyle.normal,
                                          fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
                                        ),
                                        maxLines: null,
                                      )
                                  )
                              )
                          )
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Container(
                                width: 60,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: getRecorderFn(),
                                  child: Icon(_mRecorder.isRecording ? Icons.crop_square : Icons.mic,
                                  color: Colors.white),
                                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 15, left: 15),
                                width: 60,
                                height: 60,
                                child: ElevatedButton(
                              onPressed: getPlaybackFn(),
                              child: Icon(_mPlayer.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white),
                                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),),
                            ),
                            ),
                          ]
                      ),
                       Padding(
                       padding: EdgeInsets.all(10),
                       child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/underline_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {
                                        _underline = !_underline;
                                      });
                                    }
                                )
                            ),
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/bold_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {

                                        _bold =  !_bold;
                                      });
                                    }
                                )
                            ),
                            Container(
                                child: IconButton(
                                    iconSize: 50.0,
                                    icon: Image.asset(
                                      "assets/image/italic_letter.png",
                                      color: ColorPallet.mainColor,
                                      fit: BoxFit.fill,),
                                    onPressed: () {
                                      setState(() {
                                        _italic = !_italic;
                                      });
                                    }
                                )
                            ),
                            Container(
                                width: 100,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                      isEmpty: _current == '14',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _currentSelectedValue,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _currentSelectedValue = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _current.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                            )
                          ]
                      )
            )
                    ]
                )
            )
        )
    );
  }
  _Fn getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? Myrecord : stopRecorder;
  }

  _Fn getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    return _mPlayer.isStopped ? play : stopPlayer;
  }
}
