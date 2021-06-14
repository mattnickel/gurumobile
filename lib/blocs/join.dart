import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar_animation/services/api_posts.dart';


class Join extends StatefulWidget {
  String group;
  String error;
  Join({ this.group, this.error});
  @override
  _JoinState createState() => _JoinState();

}

class _JoinState extends State<Join> {
  String joinCode;
  String _error;
  bool _processing = false;
  final joinCodeController = TextEditingController();
  final _secondFormKey = GlobalKey<FormState>();
  bool _isInvalidJoinCode= false;



  String _validateJoinCode(String joinCode){
      if (_isInvalidJoinCode){
        print("bad");
        _isInvalidJoinCode = false;
        return _error;
      }
      return null;
  }

  void _submit()async{
      final _apiMessage = await addUserToGroup(joinCode);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FocusScope.of(context).requestFocus(new FocusNode());
      if (_apiMessage == "success"){
          _processing = false;
          setState(() {
            joinCodeController.text = prefs.getString("group");
            widget.group = prefs.getString("group");
          });
      } else{
        setState(() {
          _isInvalidJoinCode = true;
          _error = _apiMessage;
          _processing = false;
        });

      }
      this._secondFormKey.currentState.validate();
  }

  leaveGroup()async{
    final _removeMessage = await removeUserGroup(widget.group);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_removeMessage == "success"){
      setState(() {
        prefs.remove("group");
        widget.group = null;
        _processing = false;
      });

    } else{
      setState(() {
        _isInvalidJoinCode = true;
        _error = _removeMessage;
        _processing = false;
      });
      this._secondFormKey.currentState.validate();
    }

  }

  FlatButton joinButtonWidget() {
    if (joinCodeController.text == '') {
      return FlatButton(

      );
    } else if (joinCodeController.text == widget.group) {
      return FlatButton.icon(
          icon: Icon(Icons.check, color: Color(0xFF09EEBC),),
          onPressed: () {
            setState(() {
              leaveGroup();
              _processing = true;
              joinCodeController.text = "";
            });
          },

          minWidth: 25,
          label: Text("Joined",
            style: TextStyle(
                color: Color(0xFF09EEBC)
            ),
          )
      );
    } else {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color(0xFF09EEBC))
          ),
          onPressed: () {
            setState(() {
              _processing = true;
            });
            if (this._secondFormKey.currentState.validate()) {
              _submit();
            }
          },
          color: Colors.transparent,
          minWidth: 25,
          child: _processing
              ? Container(
            height: 35,
            width: 35,
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF09EEBC)),
              strokeWidth: 2,

            ),
          )
              : Text("Join",
            style: TextStyle(
                color: Color(0xFF09EEBC)
            ),
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    joinCodeController.text = widget.group;

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _secondFormKey,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 5),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              validator: _validateJoinCode,
              controller: joinCodeController,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:
                  Color(0xFF09EECA)
                  ),
                ),
                helperText: "GROUP JOINCODE",
                hintText: "Enter a joincode.",
                hintStyle: TextStyle(
                    fontSize: 14),
              ),
              autocorrect: false,
              // initialValue: widget.savedJoinCode,
              onChanged: (value) {
                setState(() {
                  _isInvalidJoinCode = false;
                  joinCode = value;
                  _processing = false;
                });
                this._secondFormKey.currentState.validate();
              },
            ),
          ),
          Positioned(
              right: 70,
              top: 5,
              child: joinButtonWidget(),

          )
        ]

        ,

      ),
    );
  }
}
