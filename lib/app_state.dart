import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    _waterBottleSizeOz =
        await secureStorage.getDouble('ff_waterBottleSizeOz') ??
            _waterBottleSizeOz;
    _userWeightLbs =
        await secureStorage.getDouble('ff_userWeightLbs') ?? _userWeightLbs;
    _ozWaterToday =
        await secureStorage.getDouble('ff_ozWaterToday') ?? _ozWaterToday;
    _dayPercent = await secureStorage.getDouble('ff_dayPercent') ?? _dayPercent;
    _exercisePerDay =
        await secureStorage.getDouble('ff_exercisePerDay') ?? _exercisePerDay;
    _time1 = await secureStorage.read(key: 'ff_time1') != null
        ? DateTime.fromMillisecondsSinceEpoch(
            (await secureStorage.getInt('ff_time1'))!)
        : null;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  double _waterBottleSizeOz = 24;
  double get waterBottleSizeOz => _waterBottleSizeOz;
  set waterBottleSizeOz(double _value) {
    _waterBottleSizeOz = _value;
    secureStorage.setDouble('ff_waterBottleSizeOz', _value);
  }

  void deleteWaterBottleSizeOz() {
    secureStorage.delete(key: 'ff_waterBottleSizeOz');
  }

  double _userWeightLbs = 0;
  double get userWeightLbs => _userWeightLbs;
  set userWeightLbs(double _value) {
    _userWeightLbs = _value;
    secureStorage.setDouble('ff_userWeightLbs', _value);
  }

  void deleteUserWeightLbs() {
    secureStorage.delete(key: 'ff_userWeightLbs');
  }

  double _ozWaterToday = 30;
  double get ozWaterToday => _ozWaterToday;
  set ozWaterToday(double _value) {
    _ozWaterToday = _value;
    secureStorage.setDouble('ff_ozWaterToday', _value);
  }

  void deleteOzWaterToday() {
    secureStorage.delete(key: 'ff_ozWaterToday');
  }

  double _dayPercent = 0.0;
  double get dayPercent => _dayPercent;
  set dayPercent(double _value) {
    _dayPercent = _value;
    secureStorage.setDouble('ff_dayPercent', _value);
  }

  void deleteDayPercent() {
    secureStorage.delete(key: 'ff_dayPercent');
  }

  double _exercisePerDay = 0;
  double get exercisePerDay => _exercisePerDay;
  set exercisePerDay(double _value) {
    _exercisePerDay = _value;
    secureStorage.setDouble('ff_exercisePerDay', _value);
  }

  void deleteExercisePerDay() {
    secureStorage.delete(key: 'ff_exercisePerDay');
  }

  DateTime? _time1;
  DateTime? get time1 => _time1;
  set time1(DateTime? _value) {
    _time1 = _value;
    _value != null
        ? secureStorage.setInt('ff_time1', _value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_time1');
  }

  void deleteTime1() {
    secureStorage.delete(key: 'ff_time1');
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: ListToCsvConverter().convert([value]));
}
