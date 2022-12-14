import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p1_app/pages/infomusic_page.dart';
import 'package:p1_app/providers/animation_provider.dart';
import 'package:p1_app/providers/recordAud_provider.dart';
import 'package:provider/provider.dart';

class take_audioPage extends StatelessWidget {
  const take_audioPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animProvid = Provider.of<AnimationProvider>(context);
    final _audRc = Provider.of<RecordAudProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            _animProvid.action,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          AvatarGlow(
            animate: context.read<AnimationProvider>().getAnimation,
            glowColor: Colors.pink,
            endRadius: 170,
            repeat: true,
            showTwoGlows: true,
            duration: Duration(milliseconds: 2000),
            repeatPauseDuration: Duration(milliseconds: 1000),
            child: MaterialButton(
              elevation: 20,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 90.0,
                backgroundImage: AssetImage('assets/images/voice-recorder.png'),
              ),
              onPressed: () async {
                bool flag = true;
                print("object");
                _animProvid.changeAnimation(flag);
                var infRes =
                    await context.read<RecordAudProvider>().startRecord();
                flag = false;
                _animProvid.changeAnimation(flag);
                print("esta : $infRes");
                if (infRes.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DataMusic(
                            inf: infRes,
                          )));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.white,
              shape: CircleBorder(),
              child: Icon(
                Icons.favorite_rounded,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                print("favoritos");
                Navigator.of(context).pushNamed("/favorite_songs");
              },
            ),
          ),
        ],
      ),
    );
  }
}
