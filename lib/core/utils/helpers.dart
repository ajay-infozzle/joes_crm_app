import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';

String getStore(BuildContext context, String storeId){
  final store = context.read<HomeCubit>().storeList.firstWhere(
    (e) => e.id == storeId,
    orElse: () => Stores(id: storeId, name: '_'),
  );

  return store.name ?? '_' ;
}

String getUser(BuildContext context, String userId){
  final user = context.read<HomeCubit>().usersList.firstWhere(
    (e) => e.id == userId,
    orElse: () => Users(id: userId, name: '_'),
  );

  return user.name ?? '_' ;
}

Users? getUserObj(BuildContext context, String userId){
  if(userId.isEmpty){
    return null; 
  }

  final user = context.read<HomeCubit>().usersList.firstWhere(
    (e) => e.id == userId,
    orElse: () => Users(id: userId, name: '_'),
  );

  return user ;
}

Stores? getStoreByNameObj(BuildContext context, String name){
  if(name.isEmpty){
    return null; 
  }

  final store = context.read<HomeCubit>().storeList.firstWhere(
    (e) => e.name!.toLowerCase() == name.toLowerCase(),
    orElse: () => Stores(id: '_', name: '_'),
  );

  return store ;
}