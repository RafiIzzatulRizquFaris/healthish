class ChangeStatusHistoryContractView{
  onSuccessChangeStatus(String response){}
  onErrorChangeStatus(error){}
}

class ChangeStatusHistoryContractPresenter{
  getStatusHistoryData(String id, bool isRead){}
  loadStatusHistoryData(String id, bool isRead){}
}