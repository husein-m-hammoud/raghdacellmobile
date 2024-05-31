import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/profile_model.dart';

import '../../../../Core/global_variables.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileModel? profileModel;
  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final response = await Network.getData(url: Urls.profile);
        profileModel = ProfileModel.fromJson(response.data);

        AppSharedPreferences.preferences
            .setString("phoneNumber", profileModel!.data!.phoneNumber!);

       type = profileModel!.data!.type;
        emit(GetProfileState(profileModel: profileModel!));
      } catch (error) {
        if (error is DioException) {
          emit(ProfileErrorState(message: exceptionsHandle(error: error),code: error.response!.statusCode));
        } else {
          emit(ProfileErrorState(message: error.toString()));
        }
      }
    });
  }
}
