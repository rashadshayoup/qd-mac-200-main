import 'package:dio/dio.dart';
import 'package:pro_delivery/data/models/branch_model.dart';
import 'package:pro_delivery/data/models/change_state_request_model.dart';
import 'package:pro_delivery/data/models/city_model.dart';
import 'package:pro_delivery/data/models/order_model.dart';
import 'package:pro_delivery/data/models/signUp_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:8888/')
abstract class WebServices {
  factory WebServices(Dio dio, {String? baseUrl}) = _WebServices;

  @GET('api/Branch/GetBranchs')
  Future<BranchContent> branches();

  @GET('api/City/GetCitiesByBranchId')
  Future<CityContent> citiesByBranch({@Query('branchId') required String branchId});

  @POST('api/Order/CreateOrder')
  Future<void> addOrder({
    @Query('dscription') required String description,
    @Query('countOfItems') required String countOfItems,
    @Query('orderPrice') required String orderPrice,
    @Query('recipientPhoneNo') required String recipientPhoneNo,
    @Query('cityId') required String cityId,
    @Query('branchId') required String branchId,
  });

  @GET('api/Order/GetOrderByCustomer')
  Future<OrderContent> getOrders();

  @GET('api/Order/GetOrderByRepresentative')
  Future<OrderContent> getOrdersRepresentative();

  @POST('api/Auth/SingUp')
  Future<void> signUp({@Body() required SignUpRequest request});

  @POST('api/Order/ChangeOrderStateByRepresentative')
  Future<void> changeOrderState({
    @Body() required ChangeStateRequestRequest request,
  });

  @GET('/api/Order/GetWallet')
  Future<OrderContent> wallet();
}
