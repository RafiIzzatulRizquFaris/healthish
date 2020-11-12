class AddBookingContractView {
  onSuccessAddBooking(List<String> response) {}
  onErrorAddBooking(error) {}
}

class AddBookingContractPresenter {
  getAddBookingData(
      String idUser,
      String idDoctor,
      String idPatient,
      String date,
      String day,
      String time,
      String createAt,
      String message,
      String type) {}
  loadAddBookingData(
      String idUser,
      String idDoctor,
      String idPatient,
      String date,
      String day,
      String time,
      String createAt,
      String message,
      String type) {}
}
