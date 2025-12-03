import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo _reservationRepo;

  ReservationCubit(this._reservationRepo)
    : super(const ReservationState.initial());

  void postReservation({
    String? userId,
    required List<String> serviceIds,
    required String barberId,
    required String date,
    required String startTime,
    GuestInfo? guest,
    String? note,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());
    final response = await _reservationRepo.postReservation(
      userId: userId,
      serviceIds: serviceIds,
      barberId: barberId,
      date: date,
      startTime: startTime,
      guest: guest,
      note: note,
    );
    response.when(
      success: (reservationResponse) {
        emit(
          ReservationState.reservationSuccess(
            reservationResponse,
            arguments: arguments,
          ),
        );
      },
      failure: (error) {
        emit(ReservationState.reservationError(error));
      },
    );
  }

  void postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());
    final response = await _reservationRepo.postMultipleReservations(
      userId: userId,
      reservationsData: reservationsData,
    );
    response.when(
      success: (reservationResponse) {
        // Handle the response - we've already converted the multiple reservation response
        // to a standard reservation response in the repository
        emit(
          ReservationState.reservationSuccess(
            reservationResponse,
            arguments: arguments,
          ),
        );
      },
      failure: (error) {
        emit(ReservationState.reservationError(error));
      },
    );
  }

  void getAvailableTimeSlots({
    required String barberId,
    required DateTime date,
  }) async {
    emit(const ReservationState.timeSlotsLoading());

    // Format date as 'yyyy-MM-dd'
    final formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final response = await _reservationRepo.getAvailableTimeSlots(
      barberId: barberId,
      date: formattedDate,
    );

    response.when(
      success: (timeSlotsResponse) {
        emit(ReservationState.timeSlotsSuccess(timeSlotsResponse));
      },
      failure: (error) {
        emit(ReservationState.timeSlotsError(error));
      },
    );
  }

  void joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
    ReservationArguments? arguments,
  }) async {
    print('🟡 ReservationCubit: joinQueue called');
    emit(const ReservationState.reservationLoading());

    print('🟡 ReservationCubit: Calling repo.joinQueue...');
    final response = await _reservationRepo.joinQueue(
      barberId: barberId,
      serviceIds: serviceIds,
      userId: userId,
      guest: guest,
      note: note,
    );

    print('🟡 ReservationCubit: Response received from repo');
    response.when(
      success: (reservationResponse) {
        print('✅ ReservationCubit: Success case - emitting reservationSuccess');
        print(
          '✅ Queue data: queueNumber=${reservationResponse.data.queueNumber}, isQueue=${reservationResponse.data.isQueueReservation}',
        );
        emit(
          ReservationState.reservationSuccess(
            reservationResponse,
            arguments: arguments,
          ),
        );
        print('✅ ReservationCubit: State emitted successfully');
      },
      failure: (error) {
        print('❌ ReservationCubit: Failure case - emitting reservationError');
        print('❌ Error: ${error.apiErrorModel.message}');
        emit(ReservationState.reservationError(error));
      },
    );
  }

  void getQueueSettings() async {
    print('🔍 ReservationCubit: getQueueSettings called');
    emit(const ReservationState.queueSettingsLoading());

    final response = await _reservationRepo.getQueueSettings();

    response.when(
      success: (settingsResponse) {
        print(
          '✅ ReservationCubit: Settings received - isQueueMode: ${settingsResponse.data?.isQueueMode}',
        );
        emit(ReservationState.queueSettingsSuccess(settingsResponse));
      },
      failure: (error) {
        print(
          '❌ ReservationCubit: Settings error: ${error.apiErrorModel.message}',
        );
        emit(ReservationState.queueSettingsError(error));
      },
    );
  }

  // OTP verification methods for guest reservations
  void requestGuestVerification({required String phone}) async {
    print('🔍 ReservationCubit: requestGuestVerification called');
    emit(const ReservationState.otpRequestLoading());

    final response = await _reservationRepo.requestGuestVerification(
      phone: phone,
    );

    response.when(
      success: (otpResponse) {
        print('✅ ReservationCubit: OTP request successful');
        emit(ReservationState.otpRequestSuccess(otpResponse));
      },
      failure: (error) {
        print(
          '❌ ReservationCubit: OTP request error: ${error.apiErrorModel.message}',
        );
        emit(ReservationState.otpRequestError(error));
      },
    );
  }

  void verifyAndCreateGuestReservation({
    required String phone,
    required String otp,
    required String userName,
    required String barberId,
    required List<String> serviceIds,
    required String date,
    required String startTime,
    String? note,
    ReservationArguments? arguments,
  }) async {
    print('🔍 ReservationCubit: verifyAndCreateGuestReservation called');
    emit(const ReservationState.otpVerificationLoading());

    final response = await _reservationRepo.verifyAndCreateGuestReservation(
      phone: phone,
      otp: otp,
      userName: userName,
      barberId: barberId,
      serviceIds: serviceIds,
      date: date,
      startTime: startTime,
      note: note,
    );

    response.when(
      success: (reservationResponse) {
        print('✅ ReservationCubit: Guest reservation created successfully');
        emit(
          ReservationState.otpVerificationSuccess(
            reservationResponse,
            arguments: arguments,
          ),
        );
      },
      failure: (error) {
        print(
          '❌ ReservationCubit: Guest reservation error: ${error.apiErrorModel.message}',
        );
        emit(ReservationState.otpVerificationError(error));
      },
    );
  }
}
