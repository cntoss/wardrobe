import 'package:flutter/material.dart';

import '../../../configurations/serviceLocator/locator.dart';

class GenderDropDown extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final bloc;
  final String? initialValue;
  final SizeConfig _sizeConfig = locator<SizeConfig>();

  GenderDropDown({Key? key, this.bloc, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        initialData: initialValue == "male"
            ? "Male"
            : initialValue == "female"
                ? "Female"
                : "Other",
        stream: bloc.dropDown,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _sizeConfig.blockSizeH * 3,
                //vertical: _sizeConfig.blockSizeH * 0.5,
              ),
              child: Container(
                height: _sizeConfig.blockSizeH * 8,
                padding:
                    EdgeInsets.symmetric(horizontal: _sizeConfig.blockSizeH),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_sizeConfig.blockSizeH * 2),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(_sizeConfig.blockSizeH),
                    child: DropdownButton(
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      iconEnabledColor: Theme.of(context).primaryColor,
                      value: snapshot.data,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                      isExpanded: true,
                      isDense: true,
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: bloc.changeDropDown,
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
