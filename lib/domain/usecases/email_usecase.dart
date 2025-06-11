import 'package:joes_jwellery_crm/data/repository/email/email_repo.dart';

class EmailUsecase {
  final EmailRepository repository ;
  EmailUsecase(this.repository);

  Future<dynamic> fetchEmailTemps(){
    return repository.fetchEmailTemps();
  }

  Future<dynamic> fetchSingleEmailTemp({required String id}){
    return repository.fetchSingleEmailTemp(id: id);
  }

  Future<dynamic> deleteEmailTemp({required String id}){
    return repository.deleteEmailTemp(id: id);
  }

  Future<dynamic> addEmailTemp({required Map<String, dynamic> formdata}){
    return repository.addEmailTemp(formdata: formdata);
  }

  Future<dynamic> updateEmailTemp({required Map<String, dynamic> formdata}){
    return repository.updateEmailTemp(formdata: formdata);
  }

  Future<dynamic> fetchEmailCampgns(){
    return repository.fetchEmailCampgns();
  }

  Future<dynamic> fetchSingleEmailCampgns({required String id}){
    return repository.fetchSingleEmailCampgns(id: id);
  }

  Future<dynamic> sendEmailCampaign({required Map<String, dynamic> formdata}){
    return repository.sendEmailCampaign(formdata: formdata);
  }
}