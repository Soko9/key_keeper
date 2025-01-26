import 'package:get/get.dart';
import 'package:key_keeper/src/app/models/models.dart';
import 'package:key_keeper/src/app/services/services.dart';

class SharableController extends GetxController {
  final SharableService sharableService;
  SharableController({required this.sharableService});

  @override
  void onInit() {
    sharables.clear();
    super.onInit();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = ''.obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() => _error.value = '';

  final RxList<Sharable> _sharables = List<Sharable>.empty(growable: true).obs;
  List<Sharable> get sharables => _sharables;
  set sharables(List<Sharable> value) => _sharables.value = value;

  void addShare(Sharable share) {
    _sharables.add(share);
  }

  void removeShare(Sharable share) {
    _sharables.remove(share);
  }

  Future<void> getAllSharables({
    required String id,
    bool isRefresh = false,
  }) async {
    if (sharables.isNotEmpty && !isRefresh) return;

    isLoading = true;
    clearError();

    final either = await sharableService.getAllSharables(id: id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (shareList) {
        sharables = shareList;
      },
    );

    isLoading = false;
  }

  Future<void> sharePassword({
    required String senderID,
    required String recieverID,
    required Password password,
  }) async {
    if (senderID == recieverID) {
      error = 'You Can\'t Share Password with Yourself';
      return;
    }

    final alreadyShared = sharables
        .where(
            (s) => s.recieverID == recieverID && s.password.id == password.id)
        .toList();

    if (alreadyShared.isNotEmpty) {
      error = 'This Password Already Been Shared With This ID';
      return;
    }

    isLoading = true;
    clearError();

    final either = await sharableService.sharePassword(
      senderID: senderID,
      recieverID: recieverID,
      password: password,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (sharable) {
        addShare(sharable);
        Get.back();
      },
    );

    isLoading = false;
  }

  Future<void> deleteSharable({
    required Sharable sharable,
  }) async {
    isLoading = true;
    clearError();

    final either = await sharableService.deleteSharable(id: sharable.id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (done) {
        if (done) {
          removeShare(sharable);
        }
      },
    );

    isLoading = false;
  }
}
