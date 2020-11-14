import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/helper/constants.dart';
import 'package:healthish/contract/news_contract.dart';

class NewsPresenter implements NewsContractPresenter{

  Firestore firestore = Firestore.instance;
  NewsContractView newsContractView;

  NewsPresenter(this.newsContractView);

  @override
  Future<List<DocumentSnapshot>> getNewsData() async {
    QuerySnapshot querySnapshot = await firestore.collection(Constants.newsCollections).getDocuments();
    return querySnapshot.documents;
  }

  @override
  loadNewsData() {
    getNewsData().then((value) => newsContractView.onSuccessNewsData(value)).catchError((error) => newsContractView.onErrorNewsData(error));
  }

}