import 'package:dio/dio.dart';
import 'package:pro_delivery/data/models/branch_model.dart';
import 'package:pro_delivery/data/models/city_model.dart';
import 'package:pro_delivery/data/models/order_model.dart';
import 'package:pro_delivery/data/models/signUp_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:5108/')
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

  @GET('/api/Order/GetOrderByCustomer')
  Future<OrderContent> getOrders();


  @POST('/api/Auth/SingUp')
  Future<void> signUp({@Body() required SignUpRequest request});
}
