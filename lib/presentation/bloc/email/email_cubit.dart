import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/data/model/email_camp_list_model.dart';
import 'package:joes_jwellery_crm/data/model/email_templates_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/email_usecase.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/email_type_dropdown.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  final EmailUsecase emailUsecase ;
  EmailCubit({required this.emailUsecase}) : super(EmailInitial());

  List<Emailtpls> allEmailTemplates = [] ;
  Emailtpls? currentEmailTempl;
  EmailType? selectedEmailType ;
  List<EmailType> emailTypeList = [
    EmailType(type: "Common", value: "common"),
    EmailType(type: "Sales", value: "sales"),
    EmailType(type: "Lead", value: "lead"),
    EmailType(type: "Operator", value: "operator"),
  ];
  void changeEmailType(EmailType selectedType) {
    selectedEmailType = selectedType ;
    emit(EmailTemplFormUpdate());
  }

  Future<void> fetchAllEmailTemplates() async {
    try {
      emit(EmailTempsLoading());
      final response = await emailUsecase.fetchEmailTemps();
      final data = EmailTemplatesModel.fromJson(response);
      allEmailTemplates = data.emailtpls ?? [] ;
      emit(EmailTempsLoaded(data.emailtpls??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailTempsError(e.toString()));
    }
  }

  Future<void> fetchSingleEmailTemplate({required String id}) async {
    try {
      emit(EmailTemplDetailLoading());
      final response = await emailUsecase.fetchSingleEmailTemp(id: id);
      final data = Emailtpls.fromJson(response['emailtpl']);
      currentEmailTempl = data ;
      emit(EmailTemplDetailLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailTemplDetailError(e.toString()));
    }
  }

  Future<void> deleteEmailTemplate({required String id}) async {
    try {
      emit(EmailTemplDetailLoading());
      final response = await emailUsecase.deleteEmailTemp(id: id);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        currentEmailTempl = null ;

        await fetchAllEmailTemplates();
        emit(EmailTemplDeleted());
      }else{
        showToast(msg: "Something went wrong !", backColor: AppColor.red);
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailTemplDetailError(e.toString()));
    }
  }

  Future<void> editEmailTemplate({required Map<String , dynamic> formdata}) async {
    if(formdata['title'].isEmpty){
      showToast(msg: "Title is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['subject'].isEmpty){
      showToast(msg: "Subject is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['content'].isEmpty){
      showToast(msg: "Template is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['type'].isEmpty){
      showToast(msg: "Select template type", backColor: AppColor.red);
      return ;
    }

    try {
      emit(EmailTemplFormLoading());
      final response = await emailUsecase.updateEmailTemp(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        emit(EmailTemplFormSaved());
      }else{
        emit(EmailTemplFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailTemplFormError(e.toString()));
    }
  }

  Future<void> addEmailTemplate({required Map<String , dynamic> formdata}) async {
    if(formdata['title'].isEmpty){
      showToast(msg: "Title is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['subject'].isEmpty){
      showToast(msg: "Subject is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['content'].isEmpty){
      showToast(msg: "Template is required", backColor: AppColor.red);
      return ;
    }
    if(formdata['type'].isEmpty){
      showToast(msg: "Select template type", backColor: AppColor.red);
      return ;
    }

    try {
      emit(EmailTemplFormLoading());
      final response = await emailUsecase.addEmailTemp(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);

        await fetchAllEmailTemplates();
        emit(EmailTemplFormSaved());
      }else{
        emit(EmailTemplFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailTemplFormError(e.toString()));
    }
  }

  List<Emailcampaigns> allEmailCampgns = [];
  Future<void> fetchAllEmailCampaign() async {
    try {
      emit(EmailCampLoading());
      final response = await emailUsecase.fetchEmailCampgns();
      final data = EmailCampaignListModel.fromJson(response);
      allEmailCampgns = data.emailcampaigns ?? [] ;
      emit(EmailCampLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailCampError(e.toString()));
    }
  }

  Emailcampaign? currentEmailCamp ;
  Future<void> fetchSingleEmailCampgn({required String id}) async {
    try {
      emit(EmailCampLoading());
      final response = await emailUsecase.fetchSingleEmailCampgns(id: id);
      final data = SingleEmailCampaignModel.fromJson(response);
      currentEmailCamp = data.emailcampaign ;
      emit(EmailCampLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Email Cubit");
      emit(EmailCampError(e.toString()));
    }
  }

}
