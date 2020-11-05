import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/guide_contract.dart';

class GuidePresenter implements GuideContractPresenter {
  GuideContractView guideContractView;
  Firestore firestore = Firestore.instance;

  GuidePresenter(this.guideContractView);

  @override
  Future<List<DocumentSnapshot>> getGuideData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection(Constants.guideCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadGuideData() {
    getGuideData()
        .then((value) => guideContractView.onSuccessGuideData(value))
        .catchError((error) => guideContractView.onErrorGuideData(error));
  }
}
