import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/contract/change_status_history_contract.dart';
import 'package:healthish/helper/constants.dart';

class ChangeStatusHistoryPresenter
    implements ChangeStatusHistoryContractPresenter {
  ChangeStatusHistoryContractView changeStatusHistoryContractView;
  Firestore firestore = Firestore.instance;

  ChangeStatusHistoryPresenter(this.changeStatusHistoryContractView);

  @override
  Future<String> getStatusHistoryData(String id, bool isRead) async {
    DocumentReference documentReference =
        firestore.document('${Constants.bookingCollections}/$id');
    firestore.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (documentSnapshot.exists) {
        await transaction.update(documentReference, <String, dynamic>{
          'read': isRead ? 'read' : 'unread',
        });
      } else {
        return Constants.FAILED_RESPONSE;
      }
    });
    return Constants.SUCCESS_RESPONSE;
  }

  @override
  loadStatusHistoryData(String id, bool isRead) {
    getStatusHistoryData(id, isRead)
        .then((value) =>
            changeStatusHistoryContractView.onSuccessChangeStatus(value))
        .catchError((error) =>
            changeStatusHistoryContractView.onErrorChangeStatus(error));
  }
}
