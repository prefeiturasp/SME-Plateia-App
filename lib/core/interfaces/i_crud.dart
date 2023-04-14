// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floor/floor.dart';

abstract class ICrud<T> {
  @Insert()
  Future<void> insertEntity(T entity);

  @insert
  Future<void> insertEntities(List<T> entities);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrUpdateEntity(T entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrUpdateEntities(List<T> entities);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(T entity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntities(List<T> entities);

  @delete
  Future<void> deleteEntity(T entity);

  @delete
  Future<void> deleteEntities(List<T> entities);
}
