
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';




class AppBarWidget extends HookWidget implements PreferredSizeWidget {
  String? image;
   AppBarWidget({this.image});

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    final sharedPreferenceHelper = useState<SharedPreferenceHelper?>(null);

    useEffect(() {
      final helper = SharedPreferenceHelper();
      helper.init().then((_) {
        sharedPreferenceHelper.value = helper;
        // After initialization, call the Cubit's login method
        final userId = sharedPreferenceHelper.value?.getUserId;
        if (userId != null) {
          // context.read<LanguagesListCubit>().login(UserIdRequestModel(userId: userId));
        }
      });
    }, []);
    void refresh(){

}
    return BlocBuilder<LanguagesListCubit, LanguagesListState>(
      builder: (context, state) {
        return AppBar(
          // bottom: Container(),
          titleSpacing: 50.0,
          leading: IconButton(
            icon: Icon(Icons.menu,color: appColor,size: 30,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: InkWell(
            onTap:(){context.router.push(BottomNavigationRoute());},
            child: Container(
             height:50,
              child: Image.network(image??''), // Replace with your logo asset
            ),
          ),
          actions: [
            PopupMenuButton<lang.Data>(
              iconColor: appColor,
              position: PopupMenuPosition.under,
              onSelected: (selectedLanguage) {
                // Handle language selection here
                print('Selected language: ${selectedLanguage.name}');
                sharedPreferenceHelper.value?.saveLangCode(selectedLanguage.langCode);
                var langCode = sharedPreferenceHelper.value?.getLanguageCode;
                print(langCode);
                refresh();
                // Dispatch an action to update the language state if needed
              },
              itemBuilder: (BuildContext context) {
                return state.model.data?.map((language) {
                  return PopupMenuItem<lang.Data>(
                    value: language,
                    child: Text(language.name ?? ''),
                  );
                }).toList() ?? [];
              },
            ),
          ],
        );
      },
    );
  }
}
