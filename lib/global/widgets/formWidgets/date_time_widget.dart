import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';
import '../../constants/strings/appStrings/appStrings.dart';

class DateTimeWidget extends StatelessWidget {
  DateTimeWidget({
    Key? key,
    required bloc,
  // ignore: prefer_initializing_formals
  })  : bloc = bloc,
        super(key: key);

  final dynamic bloc;
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final UiHelper _uiHelper = locator<UiHelper>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
        stream: bloc.dateTime,
        builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _sizeConfig.blockSizeH * 3,
                  vertical: _sizeConfig.blockSizeH * 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_sizeConfig.blockSizeH * 2),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: ListTile(
                    onTap: () async {
                      final DateTime? _pickedDate = await showDatePicker(
                        context: context,
                        initialDate: snapshot.data as DateTime,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (_pickedDate != null && _pickedDate != snapshot.data) {
                        bloc.changeDate(_pickedDate);
                        _uiHelper.showToast(
                            msg:
                                "${_uiHelper.formatDate(_pickedDate)} ${UserAuthStrings.selectedBirthday}");
                      }
                    },
                    dense: true,
                    leading: Text(
                      UserAuthStrings.dateOfBirth,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: Icon(Icons.date_range),
                    title: Text(
                      _uiHelper.formatDate(snapshot.data as DateTime) ==
                              _uiHelper.formatDate(DateTime.now())
                          ? ""
                          : "${_uiHelper.formatDate(snapshot.data as DateTime)} ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
