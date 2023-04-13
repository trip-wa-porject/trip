

flutter pub run build_runner build --delete-conflicting-outputs
flutter run --web-renderer html
flutter run -d chrome --web-renderer html
flutter build web --release --web-renderer html

https://stackoverflow.com/questions/65653801/flutter-web-cant-load-network-image-from-another-domain

//流程
1. 非會員
   報名活動->加入會員->閱讀條款->填寫會員資料->收驗證信->驗證email->填寫付款資料->報名成功
   加入會員->閱讀條款->填寫會員資料->收驗證信->驗證email->首頁-登入狀態? (->瀏覽活動->報名活動->填寫付款資料->報名成功)
2. 會員
   報名活動->登入會員->填寫付款資料->報名成功
   登入會員->報名活動->填寫付款資料->報名成功

## API 相關資訊
https://docs.google.com/spreadsheets/d/1yqPApTuxa4K6kX1yaGO2A8trnz7p0czvNKbEgm2ArI0/edit#gid=0
查詢行程：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/searchTrips -d '{"type":["郊山步道","健行"],"area":["新北市","宜蘭縣"],"keyword":"桶后","level":["A","B"],"startDateFrom":"2023-04-24","startDateTo":"2023-04-25","price":[[3000,5000],[5000,10000]],"days":3}'

查詢單一會員所有行程：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/trip-b6ddf/us-central1/getUserAllTrips -d '{"userId":"123456"}'

查詢單筆行程：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getOneTrip -d '{"id":"m2ogLuNPJd12t8BgzV0b"}'

新增會員：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addUser -d '{"id":"123456","email":"amew@gmail.com","name":"陳阿喵","mobile":"0987654321","idno":"A123456789","emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'

取得會員：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getUser -d '{"id":"123456"}'

更新會員資料：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/updateUser -d '{"id":"m2ogLuNPJd12t8BgzV0b","status":"done"}'

新增報名：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addRegistration -d '{"tripId":"110001","price":5200,"paymentExpireDate":"2023-04-10","paymentInfo":{},"emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'

更新報名資訊：

curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/updateRegistration -d '{"id":"m2ogLuNPJd12t8BgzV0b-","status":0}'